$ErrorActionPreference = 'Stop'

$packageName    = 'onlyoffice'
$fileType       = 'exe'
$url            = 'https://github.com/ONLYOFFICE/DesktopEditors/releases/download/ONLYOFFICE-DesktopEditors-4.8.0/DesktopEditors_x86.exe'
$url64          = 'https://github.com/ONLYOFFICE/DesktopEditors/releases/download/ONLYOFFICE-DesktopEditors-4.8.0/DesktopEditors_x64.exe'
$softwareName   = 'onlyoffice*'
$checksum       = '38965120670677e44ad6d8eefbe841ba3a57e8acd185b58e57628ff597a92d0f'
$checksum64     = '33a83a8589b3c3ef492ea78f93cf00495a535bfda84a64bb0a04d86d2bdb4756'
$checksumTypeAll= 'sha256'
$silentArgs     = '/s /S /q /Q /quiet /silent /SILENT /VERYSILENT'

$packageArgs = @{
  packageName   = $packageName
  fileType      = $fileType
  url           = $url
  url64bit      = $url64
  softwareName  = $softwareName
  checksum      = $checksum
  checksumType  = $checksumTypeAll
  checksum64    = $checksum64
  checksumType64= $checksumTypeAll
  silentArgs    = $silentArgs
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
