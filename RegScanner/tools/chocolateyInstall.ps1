try { 
  $packageName = "RegScanner"
  $processor = Get-WmiObject Win32_Processor
  $is64bit = $processor.AddressWidth -eq 64
  $mydir = (Split-Path -parent $MyInvocation.MyCommand.Definition)
  $contentDir = ($mydir | Split-Path | Join-Path -ChildPath "content")
  $binDir = ($mydir | Split-Path | Join-Path -ChildPath "bin")
  $toolsDir = ($mydir | Split-Path | Join-Path -ChildPath "tools")
  $shortcutTarget = Join-Path $binDir "$packageName.exe"
  
   Install-ChocolateyPackage -packageName "$packageName" `
   						-fileType 'exe' `
   						-url 'http://www.nirsoft.net/utils/regscanner_setup.exe' `
   						-silentArgs '/S'

  Write-ChocolateySuccess $packageName
} catch {
  Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
  throw 
}
