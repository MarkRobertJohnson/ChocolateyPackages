function Add-PathToEnvironmentVariable {
    param(
	[Parameter(Mandatory=$true)]
	[string]$variableName, 
	[ValidateSet("Machine", "User")]
	[string]$Scope = "User",
	[Parameter(Mandatory=$true)]
	[string]$pathToAdd)

    $existingValue = [Environment]::GetEnvironmentVariable($variableName, $Scope)
    Write-Verbose "The existing value of the '$Scope' environment variable '$variableName' is '$existingValue'"
    $pathToAdd = [io.path]::GetFullPath(($pathToAdd.Trim() + '\'))
	Write-Verbose "Path: $pathToAdd"
	$paths = $existingValue.ToLower().Split(";")
	$doesPathAlreadyExist = $false
	foreach($path in $paths) {
	   $path = [io.path]::GetFullPath(($path.Trim() + '\'))

		Write-Verbose @"
Compare paths:
Existing path: $path
New path:      $pathToAdd

"@
		if($path -like $pathToAdd) {
			$doesPathAlreadyExist = $true;
			Write-Warning "The path '$pathToAdd' is already in the environment variable '$variableName'.  The path will not be added."
		} 
	}
  
    if(-not $doesPathAlreadyExist) {
    	$existingValue += ";$pathToAdd"
       
        [Environment]::SetEnvironmentVariable($variableName,$existingValue, $Scope)

        sc env:\$variableName ([Environment]::GetEnvironmentVariable($variableName, $Scope) + ";" + [Environment]::GetEnvironmentVariable($variableName, "User"))
        $newValue = gc env:\$variableName
        Write-Verbose "The new value of the '$Scope' environment variable '$variableName' is '$newValue'"
        
    }

}
$PsGetDestinationModulePath = "$env:ProgramFiles\Common Files\Modules"
Add-PathToEnvironmentVariable -variableName "PSModulePath" -scope "Machine" -pathToAdd $PsGetDestinationModulePath

(new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex