$packageName  = 'adwcleaner'
$toolsLocation= Get-ToolsLocation
$directoryPath= $(Join-Path $toolsLocation $packageName);

if (Test-Path $directoryPath) {
    Write-Output "Removing application..."
    Remove-Item -Path $directoryPath -Recurse -Force
}

$packageNameUppercase = 'AdwCleaner';
$shortcutFilePath     = $($env:ProgramData, 'Microsoft\Windows\Start Menu\Programs', "$packageNameUppercase.lnk" -join "\");

if (Test-Path $shortcutFilePath) {
    Write-Output "Removing shortcut from start menu..."
    Remove-Item -Path $shortcutFilePath -Force
}

$settingsDirPath = $(Join-Path $env:SystemDrive 'AdwCleaner');
if (Test-Path $settingsDirPath) {
    Write-Output "Removing settings and quarantine (C:/AdwCleaner)..."
    Remove-Item -Path $settingsDirPath -Recurse -Force
}