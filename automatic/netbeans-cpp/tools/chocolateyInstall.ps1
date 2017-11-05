$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

$packageName	= 'netbeans-cpp'
$fileType		= 'exe'
$32filePath		= Get-Item "$toolsDir\*_x32.exe"
$64filePath		= Get-Item "$toolsDir\*_x64.exe"
$softwareName	= 'NetBeans*'
$silentArgs		= '--silent'

$packageArgs = @{
	PackageName    	= $packageName
	FileType       	= $fileType
	File           	= $32filePath
	File64          = $64filePath
	SoftwareName	= $softwareName
	SilentArgs		= $silentArgs
	ValidExitCodes	= @(0)
}

Install-ChocolateyInstallPackage @packageArgs
