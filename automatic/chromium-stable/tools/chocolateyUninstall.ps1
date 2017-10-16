$uninstallCommand   = (Get-UninstallRegistryKey -SoftwareName "chromium").UninstallString
$isAdminInstall     = ($uninstallCommand -match "--system-level")
$silentArgs         = '--uninstall --force-uninstall'

if ($isAdminInstall) {
    $silentArgs = $silentArgs + ' --system-level';
}

$uninstallerFile = $uninstallCommand -split '"' | Where-Object {$_} | Select-Object -First 1

$packageArgs = @{
    PackageName     = 'Chromium'
    FileType        = 'exe'
    SilentArgs      = $silentArgs
    validExitCodes  = @(0,19,21)
    File            = $uninstallerFile
}

Uninstall-ChocolateyPackage @packageArgs