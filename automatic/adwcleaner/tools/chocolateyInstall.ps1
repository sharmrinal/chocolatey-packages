$ErrorActionPreference = 'Stop'

$packageName  = 'adwcleaner'
$urlToken     = 'https://toolslib.net/downloads/finish/1-adwcleaner/1199/'
$toolsLocation= Get-ToolsLocation
$directoryPath= $(Join-Path $toolsLocation $packageName);
$appPath      = $directoryPath + '\' + $packageName + '.exe';
$checksum     = '52856ec13bcc140b72755fea95eb8966ed64ad03bf6d1c3d20e139e1829264a5'
$checksumType = 'sha256'

# Get download link from token link
$page_token_source        = Invoke-WebRequest -Uri $urlToken
$url                      = ($page_token_source.Links | Where-Object href -match "^https://download.toolslib.net/download/file/" | Select-Object -First 1).href

$packageArgs = @{
  packageName   = $packageName
  url           = $url
  FileFullPath  = $appPath
  checksum      = $checksum
  checksumType  = $checksumType
}

Get-ChocolateyWebFile @packageArgs

$packageNameUppercase = 'AdwCleaner';
$ShortcutFilePath     = $env:ProgramData + '\Microsoft\Windows\Start Menu\Programs\' + $packageNameUppercase + '.lnk';
$TargetPath           = $appPath;


$ShortcutArgs = @{
  ShortcutFilePath  = $ShortcutFilePath;
  TargetPath        = $TargetPath;
}

Install-ChocolateyShortcut @ShortcutArgs


$oldShim = $(Join-Path $env:ChocolateyInstall 'bin\adwcleaner.exe')

if (Test-Path $oldShim) {
  Write-Output "Removing shim for older version (before v7.0.3.1)..."
  Remove-Item -Path $oldShim -Force
}
