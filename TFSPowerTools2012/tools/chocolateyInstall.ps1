
try { 
	$packageName = "TFSPowerTools2012"
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
   						-url 'http://visualstudiogallery.msdn.microsoft.com/b1ef7eb2-e084-4cb8-9bc7-06c3bad9148f/file/83775/3/Visual%20Studio%20Team%20Foundation%20Server%202012%20Update%202%20Power%20Tools.msi' `
   						-silentArgs '/quiet /norestart'
   						#-url64bit '' `
   						#-validExitCodes 
  
} catch {
	Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
	throw 
}
