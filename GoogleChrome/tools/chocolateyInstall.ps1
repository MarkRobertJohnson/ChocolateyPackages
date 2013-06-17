try { 
  $packageName = "GoogleChrome"
  $processor = Get-WmiObject Win32_Processor
  $is64bit = $processor.AddressWidth -eq 64
  $mydir = (Split-Path -parent $MyInvocation.MyCommand.Definition)
  $contentDir = ($mydir | Split-Path | Join-Path -ChildPath "content")
  $binDir = ($mydir | Split-Path | Join-Path -ChildPath "bin")
  $toolsDir = ($mydir | Split-Path | Join-Path -ChildPath "tools")
  $shortcutTarget = Join-Path $binDir "$packageName.exe"
  
  
  
  
  # main helpers - these have error handling tucked into them so they become the only line of your script if that is all you need.
  # installer, will assert administrative rights
   Install-ChocolateyPackage -packageName "$packageName" `
   						-fileType 'EXE' `
   						-url 'https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7BD6A68A49-27DB-63C2-D51A-863F3DC9F3BA%7D%26lang%3Den%26browser%3D2%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dtrue/update2/installers/ChromeStandaloneSetup.exe' `
   						-silentArgs ''
   						#-url64bit '' `
   						#-validExitCodes 


  Write-ChocolateySuccess $packageName
} catch {
  Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
  throw 
}
