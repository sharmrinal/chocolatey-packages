$ErrorActionPreference = 'Stop'

$packageName  = 'sylpheed'
$urlToken     = 'https://toolslib.net/downloads/finish/1-adwcleaner/1199/'
$FileFullPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\adwcleaner.exe"
$checksum     = '52856ec13bcc140b72755fea95eb8966ed64ad03bf6d1c3d20e139e1829264a5'
$checksumType = 'sha256'

# Get download link from token link
$page_token_source        = Invoke-WebRequest -Uri $urlToken
$url                      = ($page_token_source.Links | Where-Object href -match "^https://download.toolslib.net/download/file/" | Select-Object -First 1).href

$packageArgs = @{
  packageName   = $packageName
  url           = $url
  FileFullPath  = $FileFullPath
  checksum      = $checksum
  checksumType  = $checksumType
}

Get-ChocolateyWebFile @packageArgs
