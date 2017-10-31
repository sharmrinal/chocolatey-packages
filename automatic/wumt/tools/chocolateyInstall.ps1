$ErrorActionPreference = 'Stop';

$packageName        = 'wumt'
$toolsDir           = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$urlDownloadArchive = 'https://drive.google.com/uc?export=download&id=0BwJH2CazcjsINFZFc1pVdk9mNHM';
$checksum           = '9FCF858411FA55A3C2E08FBC15B0A7361596F3F3A8A7CF3B25EAE36D701802F8'
$checksumType       = 'sha256'

Write-Output 'Download the archive...';
$pathArchiveDownloaded = "$toolsDir\wumt.zip"

Get-ChocolateyWebFile `
  -PackageName $packageName `
  -FileFullPath $pathArchiveDownloaded `
  -Url $urlDownloadArchive `
  -Checksum $checksum `
  -ChecksumType $checksumType

Write-Output 'Unzip the archive...';
Get-ChocolateyUnzip `
  -FileFullPath $pathArchiveDownloaded `
  -Destination $toolsDir

Remove-Item $pathArchiveDownloaded

Write-Output 'Choose the correct arch (x64 or x86)...';
$arch       = Get-OSArchitectureWidth
$force32bit = $env:ChocolateyForceX86

if ($arch -eq '32' -or $force32bit -eq $true ) {
  Remove-Item "$toolsDir\*_x64.exe"
  $tempAppPath = "$toolsDir\wumt_x86.exe"
} else {
  Remove-Item "$toolsDir\*_x86.exe"
  $tempAppPath = "$toolsDir\wumt_x64.exe"
}

Write-Output 'Move the app to the tool directory...';
$toolsDir       = Get-ToolsLocation;
$directoryPath  = $(Join-Path $toolsDir $packageName);
$appInstallPath = $(Join-Path $directoryPath "$packageName.exe");

if (!(Test-Path $directoryPath)) {
  New-Item      -Path $directoryPath -ItemType 'Directory' 
}
Move-Item       $tempAppPath $appInstallPath
Install-BinFile -Name $packageName -Path $appInstallPath

Write-Output 'Creating a friendly shortcut...';
$dirStartMenu     = $(Join-Path $env:ProgramData 'Microsoft\Windows\Start Menu\Programs');
$ShortcutFilePath = $(Join-Path $dirStartMenu "Windows Update MiniTool.lnk");

Install-ChocolateyShortcut `
  -ShortcutFilePath $ShortcutFilePath `
  -TargetPath $appInstallPath
