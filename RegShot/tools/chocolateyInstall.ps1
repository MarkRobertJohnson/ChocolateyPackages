try { 
  
  $packageName = 'RegShot'
  $scriptDir = (Split-Path -parent $MyInvocation.MyCommand.Definition)
  $url = 'http://sourceforge.net/projects/regshot/files/regshot/1.9.0/Regshot-1.9.0.7z/download'

  $processor = Get-WmiObject Win32_Processor
  $is64bit = $processor.AddressWidth -eq 64
  if($is64bit) {
  	$shortcutTarget = "$scriptDir\Regshot-x64-Unicode.exe"
  } else {
  	$shortcutTarget = "$scriptDir\Regshot-x86-Unicode.exe"
  }

  $fileFullPath = "$env:TEMP\chocolatey\$packageName\$packageName`Install.7z"

  Get-ChocolateyWebFile $packageName $fileFullPath $url
  Start-Process "7za" -ArgumentList "x -o`"$scriptDir`" -y `"$fileFullPath`"" -Wait

  Install-ChocolateyDesktopLink $shortcutTarget

  Write-ChocolateySuccess "$packageName"
} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw 
}
