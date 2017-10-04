$ErrorActionPreference = 'Stop'

$packageName  = 'sylpheed'
$fileType     = 'exe'
$url          = 'https://sylpheed.sraoss.jp/sylpheed/win32/Sylpheed-3.6_setup.exe'
$softwareName = 'sylpheed*'
$checksum     = 'ded69a550a2b961a3ac11c94a59f762cfe224f823fc5a944328b4add58ec1520'
$checksumType = 'sha256'
$silentArgs   = "/S"

$packageArgs = @{
  packageName   = $packageName
  fileType      = $fileType
  url           = $url
  softwareName  = $softwareName
  checksum      = $checksum
  checksumType  = $checksumType
  silentArgs    = $silentArgs
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
