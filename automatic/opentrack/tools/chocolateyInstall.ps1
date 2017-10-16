$ErrorActionPreference = 'Stop';

$packageName    = 'opentrack';
$fileType       = 'exe';
$url            = 'https://github.com/opentrack/opentrack/releases/download/opentrack-2.3.9/opentrack-2.3.9-win32-setup.exe';
$softwareName   = 'opentrack*';
$checksum       = '544fb87b5742083e41346d139ca7b3d0c0427c93ff99c304bd1c87a80c99c88c';
$checksumTypeAll= 'sha256';
$silentArgs     = '/s /S /q /Q /quiet /silent /SILENT /VERYSILENT';

$packageArgs = @{
  packageName   = $packageName
  fileType      = $fileType
  url           = $url
  softwareName  = $softwareName
  checksum      = $checksum
  checksumType  = $checksumTypeAll
  silentArgs    = $silentArgs
  validExitCodes= @(0)
};

Install-ChocolateyPackage @packageArgs;
