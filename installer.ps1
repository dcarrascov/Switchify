# Genera el instalador de Switchify (dist\Switchify-Setup-<versión>.exe) con Inno Setup.
#   powershell -ExecutionPolicy Bypass -File .\installer.ps1
# Inno Setup se instala una vez con: winget install --id JRSoftware.InnoSetup -e --scope user
$ErrorActionPreference = 'Stop'
$dist = Join-Path $PSScriptRoot 'dist'
New-Item -ItemType Directory -Force $dist | Out-Null

# 1. Compila el .exe en dist\ (con ruta de salida, build.ps1 no toca la copia instalada).
$exe = Join-Path $dist 'Switchify.exe'
& (Join-Path $PSScriptRoot 'build.ps1') $exe
if (-not (Test-Path $exe)) { throw 'No se pudo compilar Switchify.exe' }

# 2. La versión sale de src\AssemblyInfo.cs (AssemblyInformationalVersion).
$info = Get-Content (Join-Path $PSScriptRoot 'src\AssemblyInfo.cs') -Raw
if ($info -notmatch 'AssemblyInformationalVersion\("([^"]+)"\)') { throw 'Falta la versión en src\AssemblyInfo.cs' }
$version = $Matches[1]

# 3. Busca el compilador de Inno Setup (instalación por usuario o para todos).
$iscc = @(
    (Join-Path $env:LOCALAPPDATA 'Programs\Inno Setup 6\ISCC.exe'),
    (Join-Path ${env:ProgramFiles(x86)} 'Inno Setup 6\ISCC.exe'),
    (Join-Path $env:ProgramFiles 'Inno Setup 6\ISCC.exe')
) | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $iscc) { throw 'No se encuentra Inno Setup 6. Instálalo con: winget install --id JRSoftware.InnoSetup -e --scope user' }

& $iscc /Q "/DAppVersion=$version" "/DSourceExe=$exe" (Join-Path $PSScriptRoot 'installer\Switchify.iss')
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
Write-Host "Instalador: $(Join-Path $dist "Switchify-Setup-$version.exe")"
