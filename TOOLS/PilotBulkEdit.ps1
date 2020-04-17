foreach($line in Get-Content .\PilotList.txt) {
Copy-Item PilotTemplate.json "$line"
}