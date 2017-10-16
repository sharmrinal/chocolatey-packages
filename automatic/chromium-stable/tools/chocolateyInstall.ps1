$ErrorActionPreference = 'Stop';

$packageName    = 'chromium-stable';
$fileType       = 'exe';
$url            = 'https://github.com/henrypp/chromium/releases/download/v61.0.3163.100-r488528-win32/chromium-sync.exe';
$url64          = 'https://github.com/henrypp/chromium/releases/download/v61.0.3163.100-r488528-win64/chromium-sync.exe';
$softwareName   = 'chromium-stable*';
$checksum       = '536d196181b0ba4ffd33bb6bfff70d88ca075f77bdc3b171a01fcddfb2cad1a6';
$checksum64     = 'de8c71e96d7b995bc8e8334160f62d713790d27d00a94856512b47abf9a417cd';
$checksumTypeAll= 'sha256';

$registryPathChromiumAsUser = 'hkcu:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Chromium';
$isChromiumInstallAsUser    = Test-Path $registryPathChromiumAsUser;
 
if ($isChromiumInstallAsUser) {
  $silentArgs = '--do-not-launch-chrome';
} else {
  $silentArgs = '--system-level --do-not-launch-chrome';
}

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
};

Install-ChocolateyPackage @packageArgs;
