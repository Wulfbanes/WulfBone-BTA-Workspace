function ConvertTo-Hashtable {
    [CmdletBinding()]
    [OutputType('hashtable')]
    param (
        [Parameter(ValueFromPipeline)]
        $InputObject
    )
 
    process {
        ## Return null if the input is null. This can happen when calling the function
        ## recursively and a property is null
        if ($null -eq $InputObject) {
            return $null
        }
 
        ## Check if the input is an array or collection. If so, we also need to convert
        ## those types into hash tables as well. This function will convert all child
        ## objects into hash tables (if applicable)
        if ($InputObject -is [System.Collections.IEnumerable] -and $InputObject -isnot [string]) {
            $collection = @(
                foreach ($object in $InputObject) {
                    ConvertTo-Hashtable -InputObject $object
                }
            )
 
            ## Return the array but don't enumerate it because the object may be pretty complex
            Write-Output -NoEnumerate $collection
        } elseif ($InputObject -is [psobject]) { ## If the object has properties that need enumeration
            ## Convert it to its own hash table and return it
            $hash = @{}
            foreach ($property in $InputObject.PSObject.Properties) {
                $hash[$property.Name] = ConvertTo-Hashtable -InputObject $property.Value
            }
            $hash
        } else {
            ## If the object isn't an array, collection, or other object, it's already a hash table
            ## So just return it.
            $InputObject
        }
    }
}

function Select-HashTable {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipeline)][Hashtable]$Hashtable,
        [String[]]$Include = ($HashTable.Keys),
        [String[]]$Exclude
    )

    if (-not $Include) {$Include = $HashTable.Keys}

    $filteredHashTable = @{}
    $HashTable.keys.where{
        $PSItem -in $Include
    }.where{
        $PSItem -notin $Exclude
    }.foreach{
        $filteredHashTable[$PSItem] = $HashTable[$PSItem]
    }
    return $FilteredHashTable
}

#Set Filepaths
$pathToJsonFile = "M:\Google Drive\Video Games\Battletech\Battletech Modding\Event Tools\pilot\pilot_at_Axle.json"
$filename = Split-Path $pathToJsonFile -leaf
$filebasename = (get-item $pathToJsonFile).basename
$pathToOutputFile = "M:\Google Drive\Video Games\Battletech\Battletech Modding\Event Tools\pilot\$filebasename.csv"

#Setup Data
$rawfile = Get-Content -Path $pathToJsonFile
$data = $rawfile  | ConvertFrom-Json 
$hash = $rawfile  | ConvertFrom-Json | ConvertTo-Hashtable


$d = $data
$de = $data.description


$tags = [String]::Join(", ",$d.pilottags.items)
$fullname = [String]::Join(" ",$de.FirstName, $de.lastname)
$stats = [String]::Join(" ",$d.basegunnery, $d.basepiloting, $d.baseguts, $d.basetactics)

$table = ('filename', $filename) + ('id', $de.ID)

$de.ID, $d.voice, $de.callsign, $de.gender, $d.age, $fullname, $de.faction, $stats, $tags, $de.details

$table | ConvertTo-Csv -NoTypeInformation | Set-Content $pathToOutputFile


#$excluded = ($hash | Select-HashTable -Exclude Description, PilotTags)
$excluded = ($hash | Select-HashTable -Include BaseGunnery, BasePiloting, BaseGuts, BaseTactics)
$filtered = $excluded + $hash.Description
$pilotTagsString = [String]::Join(", ",$data.pilottags.items)
$filtered.add('PilotTags', $pilotTagsString)
$filtered | ConvertTo-Json | ConvertFrom-Json | ConvertTo-Csv -NoTypeInformation | Set-Content $pathToOutputFile

$sorted = $filtered.GetEnumerator() | sort -Property name

$sorted |  ConvertTo-Csv -NoTypeInformation | Set-Content $pathToOutputFile


# junk


#Export to CSV
$hash | ConvertTo-Json

$hash | ConvertTo-Json | ConvertFrom-Json | ConvertTo-Csv -NoTypeInformation | Set-Content $pathToOutputFile


$pilotTagsString = [String]::Join(", ",$data.pilottags.items)
# $pilottagsArray = $pilottagsString.split(", ")

$filtered = $filtered.add('PilotTags', $pilotTagsString) 

$filtered | Select-HashTable -Exclude Bonus
| ConvertTo-Json 

$pilottagshash =





$hash.PilotTags.items

Get-Content -Path $pathToJsonFile  | ConvertFrom-Json | ConvertTo-Json


$data | Select-Object -expand Description
$data | select -expand Description, PilotTags
Get-TypeData $test

$data | Select-Object -expand Description

$data | Select-Object -expand Description


$data | Expand-NestedProperty | Out-File -FilePath $pathToOutputFile

$test = $data = Get-Content -Path $pathToJsonFile  | ConvertFrom-Json
$test | Expand-NestedProperty | Out-File -FilePath $pathToOutputFile


$data.pilottags.tagSetSourceFile

$data.description
$data |
    ConvertTo-Csv -NoTypeInformation |
    Set-Content $pathToOutputFile

$data -select names

$data | where {$.
