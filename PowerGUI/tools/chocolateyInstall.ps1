$newDisplayVersion = "3.6.0.21"
$newversion = 50397184
$installerKeyName = "{059637FE-5238-43A2-AF1B-30B830FA5168}"
$packageName = "PowerGUI" 
$downloadUrl = "http://community-downloads.quest.com/powergui/Release/3.6/PowerGUI.3.6.0.21.msi"
#NOTE: PowerGUI install/uninstall info located at 
# HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{059637FE-5238-43A2-AF1B-30B830FA5168}

$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64
$mydir = (Split-Path -parent $MyInvocation.MyCommand.Definition)
$contentDir = ($mydir | Split-Path | Join-Path -ChildPath "content")
$binDir = ($mydir | Split-Path | Join-Path -ChildPath "bin")
$toolsDir = ($mydir | Split-Path | Join-Path -ChildPath "tools")
$shortcutTarget = Join-Path $binDir '$packageName.exe'
$msiInstallLoggingArgs = "/lvoicewarmupx `"$toolsDir\${packageName}${newDisplayVersion}_install.log`""

Import-Module "$toolsDir\DeploymentUtils.psm1"
$errorActionPreference = "stop"		
function Main() {
	try {

		try {
			
			Uninstall-UnConditionally -installerKeyName $installerKeyName `
										-packageName $packageName `
										-logDir $toolsDir
		} catch {
			Write-Warning "Uninstall failed, attempting to install..."

		}
		
		Install-PowerGUI

	} catch {
	   write-warning $_
		Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
		throw 
	}
}

function Install-PowerGUI() {
	Install-ChocolateyPackage -packageName $packageName `
					-fileType 'msi' `
					-url "$downloadUrl" `
					-silentArgs "/quiet $msiInstallLoggingArgs"

}


Main
