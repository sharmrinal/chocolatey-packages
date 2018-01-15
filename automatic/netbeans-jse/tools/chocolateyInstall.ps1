$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

$packageName	= 'netbeans-jse'
$fileType		= 'exe'
$filePath		= Get-Item "$toolsDir\netbeans-*-javase-windows_x32.exe"
$softwareName	= 'NetBeans*'
$silentArgs		= '--silent'

$packageArgs = @{
	PackageName    	= $packageName
	FileType       	= $fileType
	File           	= $filePath
	SoftwareName	= $softwareName
	SilentArgs		= $silentArgs
	ValidExitCodes	= @(0)
}

Install-ChocolateyInstallPackage @packageArgs
