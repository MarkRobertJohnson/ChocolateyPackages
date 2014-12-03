$packageName = 'vcredist2012'
$installerType = 'EXE'
$32BitUrl = 'http://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe'
$64BitUrl = 'http://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe'
$silentArgs = '/Q'
$validExitCodes = @(0,3010)

try {
	#first install vcredist targetting actual CPU architecture
	Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$32BitUrl" "$64BitUrl" -validExitCodes $validExitCodes

	$is64bit = $is64bit = Get-ProcessorBits 64;
	if($is64bit) {
		#in case of x64 also install x86 vcredist
		Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$32BitUrl" -validExitCodes $validExitCodes
	}

	Write-ChocolateySuccess 'vcredist2010'
} catch {
	Write-ChocolateyFailure 'vcredist2010' "$($_.Exception.Message)"
	throw 
}