# The Windows counterpart of scripts/install.sh: installs the package as it is at the latest version tag on GitHub (the
# highest `v<major>.<minor>.<patch>`) into Typst's local package directory, under the `local` namespace:
# `#import "@local/abntly:<version>": *` and `typst init @local/abntly:<version> <folder>` then work without Typst
# Universe, before the version reaches it.
#
# Only the files published on Typst Universe are installed (the list below, kept in step with scripts/package.sh).
# The template imports the package as `@preview/abntly:<version>`, as Typst Universe requires; the installed copy
# imports it from `@local`, so that a work created from it compiles. Running it again replaces that version.
#
#   powershell -ExecutionPolicy Bypass -File scripts\install.ps1
#   irm https://raw.githubusercontent.com/lucaslrodri/abntly/main/scripts/install.ps1 | iex
#
# The package goes to %APPDATA%\typst\packages\local\abntly\<version>, or under TYPST_PACKAGE_PATH when it is set, as
# Typst does. It does not depend on the working copy, hence the second form, which runs in the open session: the body
# is a script block, so that its settings do not stay there.

& {
    $ErrorActionPreference = 'Stop'
    $ProgressPreference = 'SilentlyContinue'  # the progress bar makes Invoke-WebRequest many times slower
    # Windows PowerShell 5.1 may offer only TLS 1.0 and 1.1, which GitHub refuses
    [Net.ServicePointManager]::SecurityProtocol =
        [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

    $repo = 'lucaslrodri/abntly'
    $files = @('typst.toml', 'LICENSE', 'README.md', 'thumbnail.png', 'src', 'template')

    # The tags come sorted by name, not by version: v0.10.0 would come before v0.9.0. The list is kept in a variable
    # before it is filtered, because Windows PowerShell 5.1 sends a JSON array down a pipeline as a single object.
    $tags = Invoke-RestMethod -Uri "https://api.github.com/repos/$repo/tags?per_page=100"
    $versions = @($tags | Where-Object { $_.name -match '^v\d+\.\d+\.\d+$' } |
        ForEach-Object { [version]$_.name.Substring(1) } | Sort-Object)
    if ($versions.Count -eq 0) { throw "no tag v<major>.<minor>.<patch> found in $repo" }
    $version = $versions[-1].ToString()

    $tmp = Join-Path ([IO.Path]::GetTempPath()) ([Guid]::NewGuid().ToString())
    New-Item -ItemType Directory -Force -Path $tmp | Out-Null
    try {
        $zip = Join-Path $tmp 'source.zip'
        Invoke-WebRequest -Uri "https://github.com/$repo/archive/refs/tags/v$version.zip" -OutFile $zip
        Expand-Archive -Path $zip -DestinationPath $tmp
        $tree = (Get-ChildItem -Path $tmp -Directory | Select-Object -First 1).FullName

        $manifest = Get-Content -LiteralPath (Join-Path $tree 'typst.toml')
        $name = @($manifest | Select-String -Pattern '^name *= *"(.*)"')[0].Matches[0].Groups[1].Value
        $declared = @($manifest | Select-String -Pattern '^version *= *"(.*)"')[0].Matches[0].Groups[1].Value
        if ($declared -ne $version) { throw "the tag v$version holds version $declared in typst.toml" }

        if ($env:TYPST_PACKAGE_PATH) {
            $packages = $env:TYPST_PACKAGE_PATH
        } else {
            $packages = [IO.Path]::Combine($env:APPDATA, 'typst', 'packages')
        }
        $out = [IO.Path]::Combine($packages, 'local', $name, $version)

        # A link there (symbolic or junction) points to a working copy: it is left alone, since deleting through it
        # would erase that copy.
        $existing = Get-Item -LiteralPath $out -Force -ErrorAction SilentlyContinue
        if ($existing -and ($existing.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
            throw "$out is a link; remove it first"
        }
        if ($existing) { Remove-Item -LiteralPath $out -Recurse -Force }
        New-Item -ItemType Directory -Force -Path $out | Out-Null
        foreach ($f in $files) {
            $path = Join-Path $tree $f
            if (-not (Test-Path -LiteralPath $path)) { throw "$f is missing from the tag v$version" }
            Copy-Item -LiteralPath $path -Destination $out -Recurse -Force
        }

        # Read and written as UTF-8 by .NET: Get-Content and Set-Content of Windows PowerShell 5.1 would use the ANSI
        # code page and garble the accents of the template.
        Get-ChildItem -Path (Join-Path $out 'template') -Recurse -Filter '*.typ' | ForEach-Object {
            $text = [IO.File]::ReadAllText($_.FullName)
            [IO.File]::WriteAllText($_.FullName, $text.Replace("@preview/${name}:$version", "@local/${name}:$version"))
        }
    } finally {
        Remove-Item -Recurse -Force -Path $tmp -ErrorAction SilentlyContinue
    }

    Write-Host "@local/${name}:$version -> $out"
}
