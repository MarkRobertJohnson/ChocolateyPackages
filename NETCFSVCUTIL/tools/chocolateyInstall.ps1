
$programFiles = "${env:ProgramFiles(x86)}"
if(-not $programFiles) {
    $programFiles = "${env:ProgramFiles}"
}
$downloadLocation = "$programFiles\Microsoft.NET\SDK\CompactFramework\v3.5\bin"
if(-not (test-path $downloadLocation)) {
    mkdir $downloadLocation -force
}
$actualOutputPath = ""
 Get-ChocolateyWebFile -packageName $packageName -fileFullPath $downloadLocation -url "http://download.microsoft.com/download/6/2/0/6205ED05-E435-44FC-AA82-B763CA5F8B1A/NetCFSvcUtil.exe" -actualOutputpath ([ref]$actualOutputPath)
 Write-Host "Downloaded file: $actualOutputPath"