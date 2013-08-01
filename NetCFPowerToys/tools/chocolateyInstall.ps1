Install-ChocolateyPackage -packageName "$packageName" `
   						-fileType 'msi' `
   						-url 'http://download.microsoft.com/download/f/a/c/fac1342d-044d-4d88-ae97-d278ef697064/NETCFv35PowerToys.msi' `
   						-silentArgs '/q /norestart'

$programFiles = "${env:ProgramFiles(x86)}"
if(-not $programFiles) {
    $programFiles = "${env:ProgramFiles}"
}
$downloadLocation = "$programFiles\Microsoft.NET\SDK\CompactFramework\v3.5\bin"
$actualOutputPath = ""
 Get-ChocolateyWebFile -packageName $packageName -fileFullPath $downloadLocation -url "http://download.microsoft.com/download/6/2/0/6205ED05-E435-44FC-AA82-B763CA5F8B1A/NetCFSvcUtil.exe" -actualOutputpath ([ref]$actualOutputPath)
 Write-Host "Downloaded file: $actualOutputPath"
