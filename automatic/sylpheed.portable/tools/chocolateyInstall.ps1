$ErrorActionPreference = 'Stop'

$packageName  = 'sylpheed'
$url          = 'https://sylpheed.sraoss.jp/sylpheed/win32/sylpheed-3.7-win32.zip'
$unzipLocation= $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$checksum     = 'b1061aacf7222927e95c291e6211a6ee2034db5d87aae584b0e4234a4513b84e'
$checksumType = 'sha256'

$packageArgs = @{
  packageName   = $packageName
  url           = $url
  UnzipLocation = $unzipLocation
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
