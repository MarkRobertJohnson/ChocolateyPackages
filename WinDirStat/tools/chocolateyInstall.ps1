Install-ChocolateyPackage -packageName "$packageName" `
						-fileType 'exe' `
						-url 'http://www.fosshub.com/download/windirstat1_1_2_setup.exe' `
						-silentArgs '/S /norestart'
						#-url64bit '' `
						#-validExitCodes 

