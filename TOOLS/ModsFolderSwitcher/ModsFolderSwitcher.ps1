$Basefolder = "C:\Games\steamapps\common\BATTLETECH"
#Set Execution Directory to Battletech
$Basefolder = Split-Path $MyInvocation.MyCommand.Path

cd $Basefolder

$name = "Mods"
cls
If (Test-Path "$Basefolder\Mods") {
Write-Host "Mods Folder present. Locating
whoami.jackiechan for renaming."

If (Test-Path "$Basefolder\Mods\whoami.jackiechan") {
$name = Get-Content "$Basefolder\Mods\whoami.jackiechan"
gi "$Basefolder\Mods" | Rename-Item -NewName "$name"
Write-Host "
$name has been checked out."
}
Else {Write-Host "
Please add whoami.jackiechan 
to $Basefolder\Mods
"
pause
explorer "$Basefolder\Mods"
break}
}
Else {
Write-Host "No Mods Folder currently checked out.
"
}

$ModFolders = gci -Directory | where {$_.name -like "Mods*" -and $_.name -NotLike "ModSaves"} 

$counter = 0
$array = @()
foreach($Folder in $ModFolders) {
$counter++
Write-Host "[$counter] $Folder"
$array += $Folder
}
$Pick = Read-Host "
Select Folder to Checkout (Number)
"
$PickAdjusted = $Pick-1
$string = [system.String]::Join("",$array[$PickAdjusted])

If (Test-Path "$Basefolder\$string\whoami.jackiechan") {
$name = Get-Content "$Basefolder\$string\whoami.jackiechan"
gi "$Basefolder\$string" | Rename-Item -NewName "Mods"
Write-Host "
$name has been checked out."
pause
}
Else {
Write-Host "Failed to check out[$Pick] $String.
Please add whoami.jackiechan 
to $Basefolder\$String
"
pause
explorer "$String\Mods"
break
}
