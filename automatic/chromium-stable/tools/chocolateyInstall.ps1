$ErrorActionPreference = 'Stop';

$packageName    = 'chromium';
$fileType       = 'exe';
$url            = 'https://github.com/henrypp/chromium/releases/download/v62.0.3202.75-r499098-win32/chromium-sync.exe';
$url64          = 'https://github.com/henrypp/chromium/releases/download/v62.0.3202.75-r499098-win64/chromium-sync.exe';
$softwareName   = 'chromium*';
$checksum       = 'c34e422cef9c664a0fcc04b1667e1cbbc7e6af6b5370e5e32b77e520ffcbd78c';
$checksum64     = '0bad5323e3165463ebd5be42301f751dcfb460a9278a92560056af5f36e84e87';
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
  checksumType  = $checksumType
  checksum64    = $checksum64
  checksumType64= $checksumTypeAll
  silentArgs    = $silentArgs
  validExitCodes= @(0)
};

Install-ChocolateyPackage @packageArgs;
