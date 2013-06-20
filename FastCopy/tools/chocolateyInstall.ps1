  $mydir = (Split-Path -parent $MyInvocation.MyCommand.Definition)
  $contentDir = ($mydir | Split-Path | Join-Path -ChildPath "content")
  $binDir = ($mydir | Split-Path | Join-Path -ChildPath "bin")
  $toolsDir = ($mydir | Split-Path | Join-Path -ChildPath "tools")
  $shortcutTarget = Join-Path $binDir 'FastCopy.exe'
  
  Install-ChocolateyZipPackage 'FastCopy' `
					  -url 'http://ipmsg.org/archive/FastCopy211.zip' `
					  -unzipLocation $binDir `
					  -url64bit 'http://ipmsg.org/archive/FastCopy211_x64.zip' 

  Install-ChocolateyDesktopLink $shortcutTarget
  