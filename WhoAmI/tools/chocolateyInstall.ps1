try { #error handling is only necessary if you need to do anything in addition to/instead of the main helpers
  $packageName = "WhoAmI"
  $processor = Get-WmiObject Win32_Processor
  $is64bit = $processor.AddressWidth -eq 64
  $mydir = (Split-Path -parent $MyInvocation.MyCommand.Definition)
  $contentDir = ($mydir | Split-Path | Join-Path -ChildPath "content")
  $binDir = ($mydir | Split-Path | Join-Path -ChildPath "bin")
  $toolsDir = ($mydir | Split-Path | Join-Path -ChildPath "tools")
  $shortcutTarget = Join-Path $binDir "$packageName.exe"
  
  
  	$shortCutDir = Join-Path -path ([System.Environment]::GetFolderPath(([System.Environment+SpecialFolder]::CommonPrograms))) -child "Startup"
	Create-Shortcut -target "$mydir\WhoAmI.exe" -shortcutDir $shortCutDir

  # the following is all part of error handling
  Write-ChocolateySuccess $packageName
} catch {
  Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
  throw 
}
