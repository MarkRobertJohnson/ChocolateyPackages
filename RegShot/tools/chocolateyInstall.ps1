try { 
  
  $packageName = "RegShot"
  $processor = Get-WmiObject Win32_Processor
  $is64bit = $processor.AddressWidth -eq 64
  $mydir = (Split-Path -parent $MyInvocation.MyCommand.Definition)
  $contentDir = ($mydir | Split-Path | Join-Path -ChildPath "content")
  $binDir = ($mydir | Split-Path | Join-Path -ChildPath "bin")
  $toolsDir = ($mydir | Split-Path | Join-Path -ChildPath "tools")
  if($is64bit) {
  	$shortcutTarget = Join-Path $binDir "${packageName}_x64.exe"
  } else {
  	$shortcutTarget = Join-Path $binDir "${packageName}.exe"
  }
  
  Install-ChocolateyZipPackage "$packageName" `
					  -url 'http://downloads.sourceforge.net/project/regshot/regshot/1.8.3/v5_regshot_1.8.3_beta1_win32_x64_src_bin_v5.zip?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fregshot%2F&ts=1330245952&use_mirror=voxel' `
					  -unzipLocation $binDir

  Install-ChocolateyDesktopLink $shortcutTarget

  Write-ChocolateySuccess "$packageName"
} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw 
}
