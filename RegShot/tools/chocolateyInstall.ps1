try {
    $errorActionPreference = "stop"

    $mydir = (Split-Path -parent $MyInvocation.MyCommand.Definition)
    $contentDir = ($mydir | Split-Path | Join-Path -ChildPath "content")
    $binDir = ($mydir | Split-Path | Join-Path -ChildPath "bin")
    $toolsDir = ($mydir | Split-Path | Join-Path -ChildPath "tools")
    
    $url = 'http://superb-dca2.dl.sourceforge.net/project/regshot/regshot/1.9.0/Regshot-1.9.0.7z'
    
    $processor = Get-WmiObject Win32_Processor
    $is64bit = $processor.AddressWidth -eq 64
    if($is64bit) {
    	$shortcutTarget = "$binDir\Regshot-x64-Unicode.exe"
    } else {
    	$shortcutTarget = "$binDir\Regshot-x86-Unicode.exe"
    }
    
    $fileFullPath = "$env:TEMP\chocolatey\$packageName\${packageName}Install.7z"
    mkdir ([io.path]::GetDirectoryName($fileFullPath)) -erroraction silentlycontinue
    mkdir $binDir -erroraction silentlycontinue
    
    Get-ChocolateyWebFile -packageName $packageName -fileFullPath $fileFullPath -url $url -verbose
    Start-Process "7za" -ArgumentList "x -o`"$binDir`" -y `"$fileFullPath`"" -Wait -NoNewWindow -Verbose
    if($LASTEXITCODE) {
        throw "Error executing 7za to unzip $fileFullPath into $binPath "
    }
    Install-ChocolateyDesktopLink $shortcutTarget

} catch {
    #Without a try..catch, Chocolatey just keeps running statements, making for very ugly error output
    throw;
}