   Install-ChocolateyPackage -packageName "$packageName" `
   						-fileType 'msi' `
   						-url 'http://download.microsoft.com/download/f/a/c/fac1342d-044d-4d88-ae97-d278ef697064/NETCFv35PowerToys.msi' `
   						-silentArgs '/q /norestart'
