function Install-ChocolateyPackage {
param(
  [string] $packageName, 
  [string] $fileType = 'exe',
  [string] $silentArgs = '',
  [string] $url,
  [string] $url64bit = $url,
  $validExitCodes = @(0),
  [string]$fileName = "$($packageName)Install.$fileType" ,
  [string]$fileName64 = $fileName  
)
  
  try {

  
    Write-Debug "Running 'Install-ChocolateyPackage' for $packageName with url:`'$url`', args: `'$silentArgs`' ";


    $chocTempDir = Join-Path $env:TEMP "chocolatey"
    $tempDir = Join-Path $chocTempDir "$packageName"
    if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir) | Out-Null}
    $file = Join-Path $tempDir $fileName64
  
    Get-ChocolateyWebFile $packageName $file $url $url64bit
    Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file -validExitCodes $validExitCodes
    Write-ChocolateySuccess $packageName
  } catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw 
  }
}




try { 
    $packageName = "Gallio"
    $processor = Get-WmiObject Win32_Processor
    $is64bit = $processor.AddressWidth -eq 64
    $mydir = (Split-Path -parent $MyInvocation.MyCommand.Definition)
    $contentDir = ($mydir | Split-Path | Join-Path -ChildPath "content")
    $binDir = ($mydir | Split-Path | Join-Path -ChildPath "bin")
    $toolsDir = ($mydir | Split-Path | Join-Path -ChildPath "tools")
    $shortcutTarget = Join-Path $binDir "$packageName.exe"
  
  
	Import-Module "$toolsDir\DeploymentUtils.psm1"

    $msiexecLogPath = "${env:TEMP}\chocolatey\$packageName\${packageName}_InstallLog.txt"

    Install-ChocolateyPackage -packageName "$packageName" `
   						-fileType 'msi' `
   						-url 'https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/mb-unit/GallioBundle-3.4.14.0-Setup-x86.msi' `
   						-silentArgs '/quiet /norestart /lvoicewarmupx $msiexecLogPath'  `
   						-url64bit 'https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/mb-unit/GallioBundle-3.4.14.0-Setup-x64.msi' `
   						-fileName 'GallioBundle-3.4.14.0-Setup-x86.msi' `
   						-fileName64 'GallioBundle-3.4.14.0-Setup-x64.msi'
   						#-validExitCodes
} catch {
    Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
    throw 
}


