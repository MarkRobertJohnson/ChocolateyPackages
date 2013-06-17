try { #error handling is only necessary if you need to do anything in addition to/instead of the main helpers
  $packageName = "WebFlipScreenSaver"
  $mydir = $MyInvocation.MyCommand.Path -replace $MyInvocation.MyCommand.Name, ""
  $contentDir =  (Join-Path -path $mydir -ChildPath "content").Replace("\Tools","")
  $binDir = (Join-Path -path $mydir -ChildPath "bin").Replace("\Tools","")
  $toolsDir = $mydir
  $shortcutTarget = Join-Path $binDir "$packageName.exe"
  
	write-warning $binDir
  
 Install-ChocolateyZipPackage "$packageName" `
					  -url 'http://download.codeplex.com/Download?ProjectName=webflipscreensaver&DownloadId=347446&FileTime=129747189167700000&Build=18670' `
					  -unzipLocation $binDir 
					 # -url64bit '64BITURL' 


 Start-ChocolateyProcessAsAdmin "& '$binDir\installer.ps1'"


  $processor = Get-WmiObject Win32_Processor
  $is64bit = $processor.AddressWidth -eq 64


  # the following is all part of error handling
  Write-ChocolateySuccess $packageName
} catch {
  Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
  throw 
}
