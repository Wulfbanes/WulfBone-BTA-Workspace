#Wulfbanes wrote this to collect logs, because he could not be bothered to do it manually.
#Hope it helps you, Loki
#v1.1

#Set Execution Directory to Battletech\Mods
$Modsfolder = Split-Path $MyInvocation.MyCommand.Path

#Create Log Folder
New-Item -ItemType Directory -Force -Path "$Modsfolder\.BT Logs"

#Get Timestamp
$time = get-date -Format HH.mm


#Set dynamicpath for latest Unity Crashlog from Appdata\Temp
$crashfile = gci "$env:LOCALAPPDATA\Temp\Harebrained Schemes\BATTLETECH\Crashes"  -Recurse | 
                where {$_.name -like "error.log"} |
                Sort-Object lastwritetime |
	            Select-Object -First 1 fullname -ExpandProperty fullname


#Set dynamicpath for HBS log from Appdata\locallow
$output = "$env:USERPROFILE\Appdata\locallow\Harebrained Schemes\BATTLETECH\output_log.txt"

#Gather Logs
Copy-Item "$crashfile" "$Modsfolder\.BT Logs\$time error.log"
Copy-Item "$output" "$Modsfolder\.BT Logs\$time output.log"
Copy-Item "$Modsfolder\.modtek\ModTek.log" "$Modsfolder\.BT Logs\$time ModTek.log"
Copy-Item "$Modsfolder\cleaned_output_log.txt" "$Modsfolder\.BT Logs\$time cleaned_output_log.txt"

#Gather Made Logs into ZIP Archive
            gci "$Modsfolder\.BT Logs" |
            where {$_.name -like "$time *"} |
            Compress-Archive -DestinationPath "$Modsfolder\.BT Logs\$time BT Logs.zip"

#Open Log Folder
explorer "$Modsfolder\.BT Logs"

