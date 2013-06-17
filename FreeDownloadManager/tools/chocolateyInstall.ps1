try { #error handling is only necessary if you need to do anything in addition to/instead of the main helpers
  $packageName = "FreeDownloadManager"
  $mydir = (Split-Path -parent $MyInvocation.MyCommand.Definition)
  $contentDir = ($mydir | Split-Path | Join-Path -ChildPath "content")
  $binDir = ($mydir | Split-Path | Join-Path -ChildPath "bin")
  $toolsDir = ($mydir | Split-Path | Join-Path -ChildPath "tools")
  $shortcutTarget = Join-Path $binDir "$packageName.exe"
  
  # main helpers - these have error handling tucked into them so they become the only line of your script if that is all you need.
  # installer, will assert administrative rights
   Install-ChocolateyPackage -packageName "$packageName" `
   						-fileType 'exe' `
   						-url 'http://files.freedownloadmanager.org/fdminst.exe' `
   						-silentArgs '/silent'
   						#-url64bit '' `
   						#-validExitCodes 
  # "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT" # try any of these to get the silent installer #msi is always /quiet
  # download and unpack a zip file

  
  
  
 # Install-ChocolateyZipPackage 'TITLE' `
	#				  -url '32BITURL' `
	#				  -unzipLocation $binDir `
	#				  -url64bit '64BITURL' 

  # other helpers - using any of these means you want to uncomment the error handling up top and at bottom.
  # downloader that the main helpers use to download items
  #Get-ChocolateyWebFile 'FastCopy' 'DOWNLOAD_TO_FILE_FULL_PATH' 'http://my.vector.co.jp/servlet/System.FileDownload/download/http/0/360695/pack/win95/util/file/FastCopy208.zip' 'http://my.vector.co.jp/servlet/System.FileDownload/download/http/0/360695/pack/win95/util/file/FastCopy208_x64.zip'
  # installer, will assert administrative rights - used by Install-ChocolateyPackage
  #Install-ChocolateyInstallPackage '__NAME__' 'EXE_OR_MSI' 'SILENT_ARGS' '_FULLFILEPATH_'
  # unzips a file to the specified location - auto overwrites existing content
  #Get-ChocolateyUnzip "FULL_LOCATION_TO_ZIP.zip" "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  # Runs processes asserting UAC, will assert administrative rights - used by Install-ChocolateyInstallPackage
  #Run-ChocolateyProcessAsAdmin 'STATEMENTS_TO_RUN' 'Optional_Application_If_Not_PowerShell'
  # add specific folders to the path - any executables found in the chocolatey package folder will already be on the path. This is used in addition to that or for cases when a native installer doesn't add things to the path.
  #Install-ChocolateyPath 'LOCATION_TO_ADD_TO_PATH' 'User_OR_Machine' # Machine will assert administrative rights
  # add specific files as shortcuts to the desktop

 # Install-ChocolateyDesktopLink $shortcutTarget
  
  #------- ADDITIONAL SETUP -------#
  # make sure to uncomment the error handling if you have additional setup to do

  $processor = Get-WmiObject Win32_Processor
  $is64bit = $processor.AddressWidth -eq 64


  # the following is all part of error handling
  Write-ChocolateySuccess $packageName
} catch {
  Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
  throw 
}
