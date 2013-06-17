
try { 
	$packageName = "TFSPowerTools"
	$processor = Get-WmiObject Win32_Processor
	$is64bit = $processor.AddressWidth -eq 64
	$mydir = (Split-Path -parent $MyInvocation.MyCommand.Definition)
	$contentDir = ($mydir | Split-Path | Join-Path -ChildPath "content")
	$binDir = ($mydir | Split-Path | Join-Path -ChildPath "bin")
	$toolsDir = ($mydir | Split-Path | Join-Path -ChildPath "tools")
	$shortcutTarget = Join-Path $binDir "$packageName.exe"

	Import-Module "$toolsDir\DeploymentUtils.psm1"

	   Install-ChocolateyPackage -packageName "$packageName" `
   						-fileType 'msi' `
   						-url 'http://visualstudiogallery.msdn.microsoft.com/c255a1e4-04ba-4f68-8f4e-cd473d6b971f/file/35473/4/tfpt.msi' `
   						-silentArgs '/quiet'
   						#-url64bit '' `
   						#-validExitCodes 
  
  Write-ChocolateySuccess $packageName
} catch {
	Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
	throw 
}
