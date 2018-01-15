$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

$packageName	= 'netbeans-web'
$fileType		= 'exe'
$32filePath		= Get-Item "$toolsDir\netbeans-*-html-windows-x86_x32.exe"
$64filePath		= Get-Item "$toolsDir\netbeans-*-html-windows-x64_x64.exe"
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
