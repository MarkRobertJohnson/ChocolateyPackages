try { 
  Install-ChocolateyPackage 'LinkShellExtension' 'exe' '/S /Language=English' 'http://schinagl.priv.at/nt/hardlinkshellext/HardLinkShellExt_win32.exe' 'http://schinagl.priv.at/nt/hardlinkshellext/HardLinkShellExt_X64.exe'

  $processor = Get-WmiObject Win32_Processor
  $is64bit = $processor.AddressWidth -eq 64


  # the following is all part of error handling
  Write-ChocolateySuccess 'LinkShellExtension'
} catch {
  Write-ChocolateyFailure 'LinkShellExtension' "$($_.Exception.Message)"
  throw 
}
