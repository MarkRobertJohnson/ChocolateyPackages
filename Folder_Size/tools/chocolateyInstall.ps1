try { #error handling is only necessary if you need to do anything in addition to/instead of the main helpers
  # main helpers - these have error handling tucked into them so they become the only line of your script if that is all you need.
  # installer, will assert administrative rights
  Install-ChocolateyPackage 'Folder_Size' 'exe' '/silent' 'http://www.mindgems.com/software/FolderSize.exe'
  

  # the following is all part of error handling
  Write-ChocolateySuccess 'Folder_Size'
} catch {
  Write-ChocolateyFailure 'Folder_Size' "$($_.Exception.Message)"
  throw 
}
