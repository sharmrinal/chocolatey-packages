$ErrorActionPreference = 'Stop';

$packageName        = 'adwcleaner';
$urlBeforeDownload  = 'https://toolslib.net/downloads/finish/1-adwcleaner/1388/';
$installDir         = Get-ToolsLocation;
$directoryPath      = $(Join-Path $installDir $packageName);
$appInstallPath     = $(Join-Path $directoryPath "$packageName.exe");
$checksum           = 'c9cfb0a07961616d5c4779e8a187d2eab91d4310166c07f5063f1dc13d9ff5ba';
$checksumType       = 'sha256';

Write-Output 'Loading the author web page for getting the tempory download link...';
$regexDownloadLink        = '^https://download.toolslib.net/download/file/';
$SourcePageBeforeDownload = Invoke-WebRequest -Uri $urlBeforeDownload -UseBasicParsing;
$htmlLink                 = $SourcePageBeforeDownload.Links | Where-Object href -match $regexDownloadLink;
$url                      = $htmlLink.href;

Write-Output 'Downloading the application...';
$packageArgs = @{
  packageName   = $packageName
  url           = $url
  FileFullPath  = $appInstallPath
  checksum      = $checksum
  checksumType  = $checksumType
};

Get-ChocolateyWebFile @packageArgs;

Write-Output 'Creation of the shortcut in the start menu...';
$packageNameCamelCase = 'AdwCleaner';
$dirStartMenu         = $(Join-Path $env:ProgramData 'Microsoft\Windows\Start Menu\Programs');
$ShortcutFilePath     = $(Join-Path $dirStartMenu "$packageNameCamelCase.lnk");
$TargetPath           = $appInstallPath;

$ShortcutArgs = @{
  ShortcutFilePath  = $ShortcutFilePath
  TargetPath        = $TargetPath
};

Install-ChocolateyShortcut @ShortcutArgs;

$oldShim = $(Join-Path $env:ChocolateyInstall 'bin\adwcleaner.exe');

if (Test-Path $oldShim) {
  Write-Output "Removing shim for older version (before v7.0.3.1)...";
  Remove-Item -Path $oldShim -Force;
}
