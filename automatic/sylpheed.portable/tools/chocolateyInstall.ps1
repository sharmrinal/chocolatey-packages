$ErrorActionPreference = 'Stop'

$packageName  = 'sylpheed'
$url          = 'https://sylpheed.sraoss.jp/sylpheed/win32/sylpheed-3.6-win32.zip'
$unzipLocation= $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$checksum     = '429ea8c86303750d1ccc83967a12be13c8434beebbf492643acc53c80505dc03'
$checksumType = 'sha256'

$packageArgs = @{
  packageName   = $packageName
  url           = $url
  UnzipLocation = $unzipLocation
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
