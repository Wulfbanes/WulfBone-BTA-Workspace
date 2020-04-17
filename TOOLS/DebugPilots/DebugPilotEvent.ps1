#Import List of Pilots


$pilots = Get-Content ".\PilotListBTA.txt"

foreach($pilot in $pilots) {
#Import Blank
$text = @'
{
    "Description" : {
        "Id" : "debug_event_add_PILOTPLACEHOLDER",
        "Name" : "DEBUG ADD PILOTPLACEHOLDER",
        "Details" : "Add PILOTPLACEHOLDER",
        "Icon" : "uixTxrSpot_Store.png"
    },
    "Scope" : "Company",
    "Weight" : 1,
    "Requirements" : {
        "Scope" : "Company",
        "RequirementTags" : {
            "tagSetSourceFile" : "",
            "items" : [
                "wulf_debug"
            ]
        },
        "ExclusionTags" : {
            "tagSetSourceFile" : "",
            "items" : []
        },
        "RequirementComparisons" : []
    },
    "AdditionalRequirements" : [],
    "AdditionalObjects" : [],
    "Options" : [
        {
            "Description" : {
                "Id" : "outcome_0",
                "Name" : "Add PILOTPLACEHOLDER",
                "Details" : "-",
                "Icon" : null
            },
            "RequirementList" : [],
            "ResultSets" : [
                {
                    "Description" : {
                        "Id" : "outcome_0_0",
                        "Name" : "Add Pilot",
                        "Details" : "-",
                        "Icon" : null
                    },
                    "Weight" : 100,
                    "Results" : [
                        {
                            "Scope" : "Company",
                            "Requirements" : null,
                            "AddedTags" : {
                                "tagSetSourceFile" : "",
                                "items" : []
                            },
                            "RemovedTags" : {
                                "tagSetSourceFile" : "",
                                "items" : []
                            },
                            "Stats" : null,
                            "Actions" : [
                                {
                                    "Type" : "MechWarrior_AddRoster",
                                    "value" : "PILOTPLACEHOLDER",
                                    "valueConstant" : null,
                                    "additionalValues" : null
                                }
                            ],
                            "ForceEvents" : null,
                            "TemporaryResult" : false,
                            "ResultDuration" : 0
                        }
                    ]
                }
            ],
            "Requirements" : {
                "Scope" : "Company",
                "RequirementTags" : {
                    "tagSetSourceFile" : "",
                    "items" : []
                },
                "ExclusionTags" : {
                    "tagSetSourceFile" : "",
                    "items" : []
                },
                "RequirementComparisons" : []
            }
        }
    ],
    "PublishState" : "PUBLISHED",
    "ValidationState" : "UNTESTED",
    "EventType" : "NORMAL",
    "OneTimeEvent" : true,
    "Tags" : {
        "tagSetSourceFile" : "tags/EventTags",
        "items" : []
    }
}
'@

#Replace Placeholders
$text = $text.replace('PILOTPLACEHOLDER',"$pilot")

#Export New Event
$text | Out-file -FilePath .\debug_event_add_$pilot.json

}