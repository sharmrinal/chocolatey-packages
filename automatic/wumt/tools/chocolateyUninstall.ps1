$ErrorActionPreference = 'Stop'

Write-Output 'Remove the shortcut...';
$dirStartMenu       = $(Join-Path $env:ProgramData 'Microsoft\Windows\Start Menu\Programs');
$ShortcutFilePath   = $(Join-Path $dirStartMenu "Windows Update MiniTool.lnk");
Remove-Item         $ShortcutFilePath

Write-Output 'Remove the application...';
$packageName    = 'wumt'
$toolsDir       = Get-ToolsLocation;
$directoryPath  = $(Join-Path $toolsDir $packageName);
$appInstallPath = $(Join-Path $directoryPath "$packageName.exe");

Uninstall-BinFile   -Name $packageName -Path $appInstallPath
Remove-Item         $appInstallPath
Remove-Item         $directoryPath