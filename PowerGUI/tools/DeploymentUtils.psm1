function Get-InstalledPrograms([string]$include = "*", [switch] $detailed)
{
#EX:
#	Get-InstalledPrograms *desktop* |
#		foreach {(get-itemproperty -path $_.PSPath -name UninstallString -ea SilentlyContinue).UninstallString}

    Write-Host -for Cyan "Get-InstallPrograms -include $include -detailed:$detailed"
	$name = "";
	try {
	$items = dir -path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall
	$items += dir -path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall
	
	$items |
		foreach {
			$regObj = $_; 
			if(-not $regObj) { continue; }
			
			$name = (get-itemproperty -path $_.PSPath -name DisplayName -ea SilentlyContinue)
			if(-not $name) {
				$name = $regObj.PSChildName
			}
			else { $name = $name.DisplayName }
			if($detailed) {
				foreach ($vname in $regObj.GetValueNames()) {
					$val = $regObj.GetValue($vname);
					#$regObj[$vname] = $val;
					write-host "$vname=$val"
				}
			}

			echo $regObj
		} |
		where { 
			$_ -like $include -or $name -like $include -or $_.Name -like $include -or $_.PSChildName -like $include
		} | 
		foreach { 

			$_; 
			if($_.PSPath -and $detailed) {
				foreach ($vname in $_.GetValueNames()) {
					$val = $_.GetValue($vname);
					
					write-host "$vname=$val"
				}
				write-host -for yellow (get-itemproperty -path $_.PSPath -name UninstallString -ea SilentlyContinue) -ea SilentlyContinue;
				write-host -for yellow (get-itemproperty -path $_.PSPath -name DisplayName -ea SilentlyContinue) -ea SilentlyContinue;
			}
			
		}
	} catch {
	   Write-Warning $_
	   throw;
	}
}


function Uninstall-Conditionally(
		[Parameter(Mandatory=$true)]
		[string]$installerKeyName, 
		[Parameter(Mandatory=$true)]
		[string]$newDisplayVersion, 
		[Parameter(Mandatory=$true)]
		[int]$newVersion, 
		[Parameter(Mandatory=$true)]
		[string]$packageName,
		[Parameter(Mandatory=$true)]
		[string]$logDir) {
	write-host "checking for existing $packageName installs.."
	$regs = get-installedprograms "$installerKeyName"
	Write-host -for Cyan ($regs|out-string)
	foreach($reg in $regs) {

		$installedDisplayVersion = $reg.GetValue("DisplayVersion");
		$installedVersion = $reg.GetValue("Version");
		
		if($newDisplayVersion -like $installedDisplayVersion) {
			Write-Warning "$packageName $installedDisplayVersion is already installed (but not by Chocolatey!), not installing new version"
			return $false;
		}
		elseif($installedVersion -lt $newversion) {
			Write-Warning "$packageName $installedDisplayVersion is lower than new version: $newDisplayVersion, will uninstall existing version"
			Uninstall-UnConditionally -installerKeyName $installerkeyName `
										-packageName $packageName `
										-logDir $logDir
			return $true

		} else {
			throw "$packageName $installedDisplayVersion is a higher version than the version attempting to be installed ($newDisplayVersion), will not install"
		}
		
	}

}


function Uninstall-UnConditionally(
		[Parameter(Mandatory=$true)]
		[string]$installerKeyName, 
		[Parameter(Mandatory=$true)]
		[string]$packageName,
		[Parameter(Mandatory=$true)]
		[string]$logDir) {
		
	write-host -fore Cyan "checking for existing $packageName installs.."	
	$regs = get-installedprograms "$installerKeyName" -detailed:$false
	Write-host -for Cyan ($regs|out-string)
	try {
    	foreach($reg in $regs) {
    		$installedDisplayVersion = $reg.GetValue("DisplayVersion");
    		$installedVersion = $reg.GetValue("Version");
    		$msiUninstallLoggingArgs = "/lvoicewarmupx `"$logDir\${packageName}${installedDisplayVersion}_uninstall.log`""
    		
    		Write-Host -Fore Cyan "Start-ChocolateyProcessAsAdmin '/quiet $msiUninstallLoggingArgs /x$installerKeyName' 'msiexec'"
    		Start-ChocolateyProcessAsAdmin "/quiet $msiUninstallLoggingArgs /x$installerKeyName" 'msiexec'
    		return $true
    	}
    } catch {
        Write-Warning $_
        throw;
    }

}


Export-ModuleMember Get-InstalledPrograms
Export-ModuleMember Uninstall-Conditionally
Export-ModuleMember Uninstall-UnConditionally
