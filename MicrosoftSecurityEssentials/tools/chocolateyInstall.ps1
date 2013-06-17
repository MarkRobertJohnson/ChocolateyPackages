try { #error handling is only necessary if you need to do anything in addition to/instead of the main helpers
  $packageName = "MicrosoftSecurityEssentials"
  $mydir = (Split-Path -parent $MyInvocation.MyCommand.Definition)
  $contentDir = ($mydir | Split-Path | Join-Path -ChildPath "content")
  $binDir = ($mydir | Split-Path | Join-Path -ChildPath "bin")
  $toolsDir = ($mydir | Split-Path | Join-Path -ChildPath "tools")
  $shortcutTarget = Join-Path $binDir "$packageName.exe"

   Install-ChocolateyPackage -packageName "$packageName" `
   						-fileType 'exe' `
   						-url 'http://download.microsoft.com/download/A/3/8/A38FFBF2-1122-48B4-AF60-E44F6DC28BD8/enus/x86/mseinstall.exe' `
   						-silentArgs '/S /runwgacheck' `
   						-url64bit 'http://download.microsoft.com/download/A/3/8/A38FFBF2-1122-48B4-AF60-E44F6DC28BD8/enus/amd64/mseinstall.exe' `
   						-validExitCodes @(0,327426)


  # the following is all part of error handling
  Write-ChocolateySuccess $packageName
} catch {
  Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
  throw 
}
