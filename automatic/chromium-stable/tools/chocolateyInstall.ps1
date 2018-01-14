$ErrorActionPreference = 'Stop';

$packageName    = 'chromium';
$fileType       = 'exe';
$url            = 'https://github.com/henrypp/chromium/releases/download/v63.0.3239.132-r508578-win32/chromium-sync.exe';
$url64          = 'https://github.com/henrypp/chromium/releases/download/v63.0.3239.132-r508578-win64/chromium-sync.exe';
$softwareName   = 'chromium*';
$checksum       = '99a8829dc8eb1d6461c0d691063b1f464556093ec71d6a8b7e28a8cde6b74846';
$checksum64     = 'c3ab42c5b553452078027e867282a379d8a84f6ce1bfa4a22bc40fcd5aca6524';
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
