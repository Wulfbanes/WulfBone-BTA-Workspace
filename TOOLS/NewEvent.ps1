#Used to generate bare bones event as input for Event Editor who otherwise gets upset.

#Set Scope
$scopein = Read-Host 'Event for 1 Company, or 2 MechWarrior (ex. 1 or 2)'
#Sanitize Input
if ($scopein -eq "1") {$scope = "Company"; $scopeshort = "co"}
elseif ($scopein -eq "2") {$scope = "MechWarrior"; $scopeshort = "mw"}
else  {Write-Host "Not a Valid Input. Stopping"; pause; break}

#Set FileName
$prefix = Read-Host 'Event Prefix used to group files (ex. modder name)'
$id = Read-Host 'Event Suffix used to identify event (ex. barracksFire, introArchangel)'

#Sanitize Filename
$prefix = $prefix.replace(' ','')
$id =     $id.replace(' ','')
$file = (-join("$prefix","_event_","$scopeshort","_","$id"))

#Import Blank
# $text = Get-Content -Path NewEventTemplate.json
# or
$text = @'
{
    "Description" : {
        "Id" : 		"PLACEHOLDER_FILE",
        "Name" : 	"PLACEHOLDER NAME",
        "Details" : "PLACEHOLDER INTRO TEXT",
        "Icon" : 	"uixTxrSpot_Store.png"
    },
    "Scope" : "PLACEHOLDER_SCOPE",
    "Weight" : 10000,
    "Requirements" : {
        "Scope" : "PLACEHOLDER_SCOPE",
        "RequirementTags" : {
            "tagSetSourceFile" : "",
            "items" : []
        },
        "ExclusionTags" : {
            "tagSetSourceFile" : "",
            "items" : []
        },
        "RequirementComparisons" : []
    },
    "AdditionalRequirements" : [],
    "AdditionalObjects" : [],
    "Options" : [],
    "PublishState" : 		"PUBLISHED",
    "ValidationState" : 	"UNTESTED",
    "EventType" : 			"NORMAL",
    "OneTimeEvent" : true,
    "Tags" : {
        "tagSetSourceFile" : "tags/EventTags",
        "items" : []
    }
}
'@

#Replace Placeholders
$text = $text.replace('PLACEHOLDER_FILE',"$file")
$text = $text.replace('PLACEHOLDER_SCOPE',"$scope")

#Export New Event
$text | Out-file -FilePath .\$file.json