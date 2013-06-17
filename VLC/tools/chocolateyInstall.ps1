try { #error handling is only necessary if you need to do anything in addition to/instead of the main helpers
  $packageName = "VLC"
  $mydir = (Split-Path -parent $MyInvocation.MyCommand.Definition)
  $contentDir = ($mydir | Split-Path | Join-Path -ChildPath "content")
  $binDir = ($mydir | Split-Path | Join-Path -ChildPath "bin")
  $toolsDir = ($mydir | Split-Path | Join-Path -ChildPath "tools")
  $shortcutTarget = Join-Path $binDir "$packageName.exe"
  
  # main helpers - these have error handling tucked into them so they become the only line of your script if that is all you need.
  # installer, will assert administrative rights
   Install-ChocolateyPackage -packageName "$packageName" `
   						-fileType 'exe' `
   						-url 'http://iweb.dl.sourceforge.net/project/vlc/2.0.0/win32/vlc-2.0.0-win32.exe' `
   						-silentArgs '/S'
   						#-url64bit '' `
   						#-validExitCodes 
 
  $processor = Get-WmiObject Win32_Processor
  $is64bit = $processor.AddressWidth -eq 64


  # the following is all part of error handling
  Write-ChocolateySuccess $packageName
} catch {
  Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
  throw 
}
