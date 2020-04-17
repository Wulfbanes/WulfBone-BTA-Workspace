$Basefolder = "M:\Github\WulfBone-BTA-Workspace"
#Set Execution Directory to Workspace Folder
$Basefolder = Split-Path $MyInvocation.MyCommand.Path

#Instanciate from BaseFolder
cd $Basefolder

#Empty MODS folder
gci $basefolder\MODS | Select-Object | Remove-Item -Recurse -force

#Copy Contents of folders to MODS
Copy-Item -Path "$basefolder\BASE\*"     -Filter * -Destination "$basefolder\MODS" –Recurse -Force
Copy-Item -Path "$basefolder\CLANS\*"    -Filter * -Destination "$basefolder\MODS" –Recurse -Force
Copy-Item -Path "$basefolder\DEBUG\*"    -Filter * -Destination "$basefolder\MODS" –Recurse -Force
Copy-Item -Path "$basefolder\DEVTBONE\*" -Filter * -Destination "$basefolder\MODS" –Recurse -Force
Copy-Item -Path "$basefolder\DEVWULF\*"  -Filter * -Destination "$basefolder\MODS" –Recurse -Force