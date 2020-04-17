foreach($line in Get-Content .\List.txt) {
Copy-Item Starter_BTA_.json "Starter_BTA_$line.json"
}