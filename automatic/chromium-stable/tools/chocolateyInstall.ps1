$ErrorActionPreference = 'Stop';

$packageName    = 'chromium';
$fileType       = 'exe';
$url            = 'https://github.com/henrypp/chromium/releases/download/v62.0.3202.62-r499098-win32/chromium-sync.exe';
$url64          = 'https://github.com/henrypp/chromium/releases/download/v62.0.3202.62-r499098-win64/chromium-sync.exe';
$softwareName   = 'chromium*';
$checksum       = 'b79649e84b5efea76fbf6a72b9b03f2c2b69b6aff29317e6400505e65015b81c';
$checksum64     = '2b4766a2c316d63a2c531097ba8b9144a945d5a465d29bbdc79ac60b76128416';
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
