$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64
$mydir = (Split-Path -parent $MyInvocation.MyCommand.Definition)
$contentDir = ($mydir | Split-Path | Join-Path -ChildPath "content")
$binDir = ($mydir | Split-Path | Join-Path -ChildPath "bin")
$toolsDir = ($mydir | Split-Path | Join-Path -ChildPath "tools")


Import-Module PsGet

Install-Module -modulename $packageName -modulepath (Join-Path $toolsDir "ChocolateyDeploymentUtils.psm1") -global -force -addtoprofile