# The Windows counterpart of scripts/fonts.sh: downloads New Computer Modern, the family the package uses, from CTAN
# into fonts/, which is git-ignored (the roman and the sans in the cuts 08 and 10, the mono and the maths), then
# installs those files for the current user, without administrator rights.
#
#   powershell -ExecutionPolicy Bypass -File scripts\fonts.ps1            downloads and installs
#   powershell -ExecutionPolicy Bypass -File scripts\fonts.ps1 -NoInstall only downloads
#
# The files go to %LOCALAPPDATA%\Microsoft\Windows\Fonts and are registered under
# HKCU\Software\Microsoft\Windows NT\CurrentVersion\Fonts, as Windows 10 (1809) and later do for a per-user install.
# Programs that were open see the fonts after they restart. Running it again downloads and copies only what is missing
# or changed. Keep the lists below in step with scripts/fonts.sh.
param([switch]$NoInstall)

$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'  # the progress bar makes Invoke-WebRequest many times slower

$root = Split-Path -Parent $PSScriptRoot
$fontsDir = Join-Path $root 'fonts'
New-Item -ItemType Directory -Force -Path $fontsDir | Out-Null
$tmp = Join-Path ([IO.Path]::GetTempPath()) ([Guid]::NewGuid().ToString())
New-Item -ItemType Directory -Force -Path $tmp | Out-Null

# CTAN mirrors, in order. The redirector (mirrors.ctan.org) comes last: some of the mirrors it picks answer a script
# with an anti-bot "verification" page instead of the file, so every download is checked as a zip.
$mirrors = @('https://ctan.math.illinois.edu', 'https://mirrors.mit.edu/CTAN', 'https://ftp.fau.de/ctan',
              'https://mirrors.ctan.org')

function Test-Zip([string]$path) {
    if (-not (Test-Path -LiteralPath $path)) { return $false }
    $bytes = [IO.File]::ReadAllBytes($path)
    return $bytes.Length -gt 4 -and $bytes[0] -eq 0x50 -and $bytes[1] -eq 0x4B
}

# One sentinel per download: when it is missing, the archive is fetched again and the files whose names match the
# patterns are copied to fonts/.
function Save-CtanZip([string]$archive, [string]$sentinel, [string[]]$patterns) {
    if (Test-Path -LiteralPath (Join-Path $fontsDir $sentinel)) { return }
    Write-Host "missing in fonts/: $sentinel (downloading $archive.zip)"
    $zip = Join-Path $tmp "$archive.zip"
    $downloaded = $false
    foreach ($mirror in $mirrors) {
        try {
            Invoke-WebRequest -Uri "$mirror/fonts/$archive.zip" -OutFile $zip
            if (Test-Zip $zip) { $downloaded = $true; break }
        } catch { }
        Write-Host "  $mirror did not deliver $archive.zip; trying the next mirror"
    }
    if (-not $downloaded) { throw "could not download $archive.zip from CTAN" }
    $folder = Join-Path $tmp $archive
    Expand-Archive -Path $zip -DestinationPath $folder -Force
    Get-ChildItem -Path $folder -Recurse -File |
        Where-Object { $name = $_.Name; @($patterns | Where-Object { $name -like $_ }).Count -gt 0 } |
        Copy-Item -Destination $fontsDir -Force
}

try {
    # New Computer Modern: Roman and Sans in 08 and 10, Mono in 10, the maths (the Uncial and Devanagari cuts stay out)
    Save-CtanZip 'newcomputermodern' 'NewCM08-Regular.otf' @(
        'NewCM08-*.otf', 'NewCM10-*.otf', 'NewCMSans08-*.otf', 'NewCMSans10-*.otf', 'NewCMMono10-*.otf',
        'NewCMMath-*.otf')
} finally {
    Remove-Item -Recurse -Force -Path $tmp -ErrorAction SilentlyContinue
}
Write-Host "fonts/: $(@(Get-ChildItem -Path $fontsDir -File).Count) files"

if ($NoInstall) { exit 0 }
if (-not ($env:OS -eq 'Windows_NT')) {
    Write-Error 'this script installs fonts on Windows only; on macOS and Linux, run scripts/fonts.sh'
}

# What is installed: the Regular and Bold weights with their italics and obliques (not the Book weight)
$package = @(
    'NewCM10-Regular', 'NewCM10-Italic', 'NewCM10-Bold', 'NewCM10-BoldItalic', 'NewCM08-Regular', 'NewCM08-Italic',
    'NewCMSans10-Regular', 'NewCMSans10-Oblique', 'NewCMSans10-Bold', 'NewCMSans10-BoldOblique',
    'NewCMSans08-Regular', 'NewCMSans08-Oblique', 'NewCMMono10-Regular', 'NewCMMono10-Italic', 'NewCMMono10-Bold',
    'NewCMMono10-BoldOblique', 'NewCMMath-Regular', 'NewCMMath-Bold')

$destination = Join-Path $env:LOCALAPPDATA 'Microsoft\Windows\Fonts'
New-Item -ItemType Directory -Force -Path $destination | Out-Null
$registry = 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts'
if (-not (Test-Path -LiteralPath $registry)) { New-Item -Path $registry -Force | Out-Null }

$copied = 0
foreach ($f in $package) {
    $source = Join-Path $fontsDir "$f.otf"
    $target = Join-Path $destination "$f.otf"
    $same = (Test-Path -LiteralPath $target) -and ((Get-FileHash $source).Hash -eq (Get-FileHash $target).Hash)
    if (-not $same) {
        try {
            Copy-Item -Path $source -Destination $target -Force
        } catch {
            Write-Error ("cannot overwrite $target, which a program is using: close the programs that use the " +
                         'font and run again')
        }
        $copied++
    }
    New-ItemProperty -Path $registry -Name "$f (OpenType)" -Value $target -PropertyType String -Force | Out-Null
}
Write-Host "${destination}: $copied of $($package.Count) New Computer Modern files installed or updated"
