# This script contains some simple PowerShell commands that we will use for debugging practice.

function  Demo-Function {
    param (
        [int]$Repetition = 2
    )
    Write-Output "This is a demo function"
    while ($Repetition -gt 0) {
        Write-Output "This is repetition number $Repetition" 
        $Repetition--       
    }
}

Write-Host "This is a demo script" -ForegroundColor Green -BackgroundColor Black
Write-Host "This is a another command in yourdemo script" -ForegroundColor Green -BackgroundColor Black
Get-Demo -Repetition 2
Write-Host "The script has ended." -ForegroundColor Green -BackgroundColor Black