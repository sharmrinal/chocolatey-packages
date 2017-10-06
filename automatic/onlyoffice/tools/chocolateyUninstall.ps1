$ErrorActionPreference = 'Stop'

$packageName    = 'onlyoffice'
$fileType       = 'exe'
$silentArgs     = '/s /S /q /Q /quiet /silent /SILENT /VERYSILENT'

$processor_type = Get-WmiObject Win32_Processor
$is64bit        = $processor_type.AddressWidth -eq 64
if ($is64bit) {
  $file         = "${Env:ProgramFiles}\ONLYOFFICE\DesktopEditors\unins000.exe"
} else {
  $file         = "$Env:Env:ProgramFiles(x86)}\ONLYOFFICE\DesktopEditors\unins000.exe"
}

$packageArgs = @{
  packageName   = $packageName
  fileType      = $fileType
  silentArgs    = $silentArgs
  file          = $file
  validExitCodes= @(0)
}

Uninstall-ChocolateyPackage @packageArgs