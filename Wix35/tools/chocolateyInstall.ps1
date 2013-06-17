
  $processor = Get-WmiObject Win32_Processor
  $is64bit = $processor.AddressWidth -eq 64
  $mydir = (Split-Path -parent $MyInvocation.MyCommand.Definition)
  $contentDir = ($mydir | Split-Path | Join-Path -ChildPath "content")
  $binDir = ($mydir | Split-Path | Join-Path -ChildPath "bin")
  $toolsDir = ($mydir | Split-Path | Join-Path -ChildPath "tools")
  $shortcutTarget = Join-Path $binDir "$packageName.msi"
  
  
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


    $msiexecLogPath = "${env:TEMP}\chocolatey\$packageName\${packageName}_InstallLog.txt"

    Install-ChocolateyPackage -packageName $packageName `
   						-fileType 'msi' `
   						-url 'http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=wix&DownloadId=204417&FileTime=129409234222130000&Build=20489' `
   						-silentArgs "/quiet /norestart /lvoicewarmupx $msiexecLogPath"  `
   						-url64bit 'http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=wix&DownloadId=204417&FileTime=129409234222130000&Build=20489' `
   						-fileName 'Wix35.msi' `
   						-fileName64 'Wix35.msi' `
   						-validExitCodes @(0)
   						


