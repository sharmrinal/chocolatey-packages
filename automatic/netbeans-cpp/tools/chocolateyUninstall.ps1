$ErrorActionPreference = 'Stop'

# Uninstall Netbeans
$regeditItem 		= 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\nbi-nb-base*'
$UninstallProperty	= Get-ItemProperty -Path $regeditItem -Name 'UninstallString'

$packageName  	= 'netbeans-cpp'
$fileType     	= 'EXE'
$silentArgs   	= '--silent'
$uninstallPath	= $UninstallProperty.UninstallString

Uninstall-ChocolateyPackage -PackageName $packageName -FileType $fileType -SilentArgs $silentArgs -File $uninstallPath -ValidExitCodes @(0)