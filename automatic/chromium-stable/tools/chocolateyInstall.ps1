$ErrorActionPreference = 'Stop';

$packageName    = 'chromium';
$fileType       = 'exe';
$url            = 'https://github.com/henrypp/chromium/releases/download/v64.0.3282.168-r520840-win32/chromium-sync.exe';
$url64          = 'https://github.com/henrypp/chromium/releases/download/v64.0.3282.168-r520840-win64/chromium-sync.exe';
$softwareName   = 'chromium*';
$checksum       = '1759259469563a6a49345c2353651ad9610ad83dbe6c93df5ef6474e6c37d8d7';
$checksum64     = 'd863f1bf6f135c3c3d753f69f1616594bf25eac3a3e3cc59c6e58d035319099e';
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
