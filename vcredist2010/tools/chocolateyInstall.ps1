$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64
Install-ChocolateyPackage 'vcredist2010' 'exe' '/Q' 'https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe' `
            -checksum 67313B3D1BC86E83091E8DE22981F14968F1A7FB12EB7AD467754C40CD94CC3D `
            -checksumType sha256

                
if($is64bit) {
    Install-ChocolateyPackage 'vcredist2010_x64' 'exe' '/Q' 'https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe' `
            -checksum64 CC7EC044218C72A9A15FCA2363BAED8FC51095EE3B2A7593476771F9EBA3D223 `
            -checksumType64 sha256
}