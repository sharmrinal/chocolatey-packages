$ErrorActionPreference = 'Stop';

$toolsDir           = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$urlDownloadArchive = 'https://drive.google.com/uc?export=download&id=0BwJH2CazcjsINFZFc1pVdk9mNHM';
$checksum           = '9FCF858411FA55A3C2E08FBC15B0A7361596F3F3A8A7CF3B25EAE36D701802F8'
$checksumType       = 'sha256'

Write-Output 'Download the archive...';
$pathArchiveDownloaded = "$toolsDir\wumt.zip"

Get-ChocolateyWebFile `
  -PackageName 'wumt' `
  -FileFullPath $pathArchiveDownloaded `
  -Url $urlDownloadArchive `
  -Checksum $checksum `
  -ChecksumType $checksumType

Write-Output 'Unzip the archive...';
Get-ChocolateyUnzip `
  -FileFullPath $pathArchiveDownloaded `
  -Destination $toolsDir

Remove-Item $pathArchiveDownloaded

Write-Output 'Get arch type...';
$arch = Get-OSArchitectureWidth

Write-Output 'Keep the right binary...';
if ($arch -eq '32') {
  Remove-Item "$toolsDir\*_x64.exe"
  $appPath = "$toolsDir\wumt_x86.exe"
} else {
  Remove-Item "$toolsDir\*_x86.exe"
  $appPath = "$toolsDir\wumt_x64.exe"
}

Write-Output 'Creating a friendly shortcut...';
$dirStartMenu     = $(Join-Path $env:ProgramData 'Microsoft\Windows\Start Menu\Programs');
$ShortcutFilePath = $(Join-Path $dirStartMenu "Windows Update MiniTool.lnk");

Install-ChocolateyShortcut `
  -ShortcutFilePath $ShortcutFilePath `
  -TargetPath $appPath
