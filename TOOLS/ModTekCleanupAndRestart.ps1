$Modsfolder = "C:\Games\steamapps\common\BATTLETECH\Mods"
#Set Execution Directory to Battletech\Mods
$Modsfolder = Split-Path $MyInvocation.MyCommand.Path

gci "$Modsfolder\.modtek" | Select-Object | Remove-Item -Recurse -force



cd "$ModsFolder\Modtek\"
Start "ModTekInjector.exe" 
Read-Host "Press Enter when ModTekInjector has finished to boot the game."

cd "$Modsfolder"
cd ..

Start "BattleTech.exe"