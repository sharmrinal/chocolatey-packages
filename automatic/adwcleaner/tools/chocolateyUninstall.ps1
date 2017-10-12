$packageName    = 'adwcleaner';
$installDir     = Get-ToolsLocation;
$appDirPath     = $(Join-Path $installDir $packageName);

if (Test-Path $appDirPath) {
    Write-Output "Removing the application...";
    Remove-Item -Path $appDirPath -Recurse -Force;
}

$packageNameCamelCase = 'AdwCleaner';
$dirStartMenu         = $(Join-Path $env:ProgramData 'Microsoft\Windows\Start Menu\Programs');
$shortcutPath         = $(Join-Path $dirStartMenu "$packageNameCamelCase.lnk");

if (Test-Path $shortcutPath) {
    Write-Output "Removing the shortcut from start menu...";
    Remove-Item -Path $shortcutPath -Force;
}

$settingsDirPath = $(Join-Path $env:SystemDrive 'AdwCleaner');

if (Test-Path $settingsDirPath) {
    Write-Output "Removing settings and the quarantine (often the directory C:/AdwCleaner)...";
    Remove-Item -Path $settingsDirPath -Recurse -Force;
}