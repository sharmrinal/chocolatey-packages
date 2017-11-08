$ErrorActionPreference = 'Stop';

$packageName    = 'chromium';
$fileType       = 'exe';
$url            = 'https://github.com/henrypp/chromium/releases/download/v62.0.3202.89-r499098-win32/chromium-sync.exe';
$url64          = 'https://github.com/henrypp/chromium/releases/download/v62.0.3202.89-r499098-win64/chromium-sync.exe';
$softwareName   = 'chromium*';
$checksum       = '1d36d55a7981ae4ef9b54ec2c0c1ec626da1a73da2bf42e3b884b62a3d73048b';
$checksum64     = 'a7d242010ca8c26aaa82e21df08866141fcf66d4ade513363b0ca853f597e243';
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
