function Get-BreakPoint {
    Write-Output "Get-BreakPoint function starts"
    if ($true) {
        Write-Output "This is allways true"
    }
}
$file = 'c:\temp\2.txt'
Get-BreakPoint
Write-Output "In the script again"
Write-Output "$file"

Set-PSBreakpoint -Script .\do-something.ps1 -Command 'Write-Output' -Action { 'line' | Out-File -FilePath 'c:\temp\1.txt' -Append}
Set-PSBreakpoint -Script .\do-something.ps1 -Variable file -Action { "The value is $file" | Out-File -FilePath 'c:\temp\2.txt' -Append}


