$newDisplayVersion = "3.8.0.129"
$newversion = 50855936
$installerKeyName = "{4498748D-F54C-4B84-AD4D-F8DA827FF65E}"
$packageName = "PowerGUI" 
$downloadUrl = "http://community-downloads.quest.com/powergui/Release/3.8/PowerGUI.3.8.0.129.msi"
#NOTE: PowerGUI install/uninstall info located at 
#32bit OS: get-itemproperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$installerKeyName
#64bit OS: get-itemproperty HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$installerKeyName


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
