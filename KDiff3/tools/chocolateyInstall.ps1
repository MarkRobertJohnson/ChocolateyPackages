try { #error handling is only necessary if you need to do anything in addition to/instead of the main helpers
  $packageName = "KDiff3"
  $processor = Get-WmiObject Win32_Processor
  $is64bit = $processor.AddressWidth -eq 64
  $mydir = (Split-Path -parent $MyInvocation.MyCommand.Definition)
  $contentDir = ($mydir | Split-Path | Join-Path -ChildPath "content")
  $binDir = ($mydir | Split-Path | Join-Path -ChildPath "bin")
  $toolsDir = ($mydir | Split-Path | Join-Path -ChildPath "tools")
  $shortcutTarget = Join-Path $binDir "$packageName.exe"
  

   Install-ChocolateyPackage -packageName "$packageName" `
   						-fileType 'exe' `
   						-url 'http://iweb.dl.sourceforge.net/project/kdiff3/kdiff3/0.9.96/KDiff3Setup_0.9.96.exe' `
   						-silentArgs '/S'
   						#-url64bit '' `
   						#-validExitCodes 



  # the following is all part of error handling
  Write-ChocolateySuccess $packageName
} catch {
  Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
  throw 
}
