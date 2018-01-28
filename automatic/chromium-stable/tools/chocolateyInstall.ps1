$ErrorActionPreference = 'Stop';

$packageName    = 'chromium';
$fileType       = 'exe';
$url            = 'https://github.com/henrypp/chromium/releases/download/v64.0.3282.119-r520840-win32/chromium-sync.exe';
$url64          = 'https://github.com/henrypp/chromium/releases/download/v64.0.3282.119-r520840-win64/chromium-sync.exe';
$softwareName   = 'chromium*';
$checksum       = '89cfa48cec1d9bd997b0e9ba5633faad82538bd29d62ee8afb2a4db8941de1a6';
$checksum64     = '06d69e0d9393f1b6bac4359bbd47a469005dfb89adaa786859dcdafa6e4c2e7a';
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
