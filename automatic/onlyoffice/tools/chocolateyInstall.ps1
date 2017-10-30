$ErrorActionPreference = 'Stop'

$packageName    = 'onlyoffice'
$fileType       = 'exe'
$url            = 'https://github.com/ONLYOFFICE/DesktopEditors/releases/download/ONLYOFFICE-DesktopEditors-4.4.1/DesktopEditors_x86.exe'
$url64          = 'https://github.com/ONLYOFFICE/DesktopEditors/releases/download/ONLYOFFICE-DesktopEditors-4.4.1/DesktopEditors_x64.exe'
$softwareName   = 'onlyoffice*'
$checksum       = '33344352670532e634d19bf3ad17c0b93fcc3cccc58edb9219ade902756fec33'
$checksum64     = '4e1049337c80713a37189cfcb0d08916ed610be26baf48b3fc6ad8ddfca4e4d1'
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
