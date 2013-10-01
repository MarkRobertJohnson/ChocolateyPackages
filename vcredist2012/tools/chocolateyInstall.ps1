Install-ChocolateyPackage -packageName $packageName -fileType 'exe' -silentArgs '/Q' `
                    -url 'http://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU3/vcredist_x86.exe' `
                    -url64bit 'http://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU3/vcredist_x64.exe'


