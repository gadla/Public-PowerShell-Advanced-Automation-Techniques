function Get-Module3 {
    $CimBios = Get-CimInstance -ClassName Win32_BIOS
    $CimOs = Get-CimInstance -ClassName Win32_OperatingSystem
    $CimCs = Get-CimInstance -ClassName Win32_ComputerSystem
    
    $result = [pscustomobject]@{
        'ComputerName'     = $CimCs.Name
        'BiosSerialNumber' = $CimBios.SerialNumber
        'OperatingSystem'  = $CimOs.Caption 
        'ComputerModel'    = $CimCs.Model
        'Memory(GB)'       = ([int]($CimCs.TotalPhysicalMemory /1gb))
    }

    Write-Output $result
}

#  This is Exercise 2
#  If you wish to use it save it into a file and run it from the command line

#Requires -RunAsAdministrator
function Get-ProcessReport {

    # Step 2: Get the username
    $user = $env:USERNAME
    
    # Step 3: Get a list of processes and filter only the logged on user processes
    $processes = Get-Process -IncludeUserName | Where-Object { $_.UserName -like "*$user*" }

    # Step 4: Create a report object
    $report = foreach ($process in $processes) {
        [PSCustomObject]@{
            ProcessName = $process.ProcessName
            MemoryUsage = [math]::Ceiling($process.WorkingSet64)
            CPUUsage = [math]::Ceiling($process.CPU)
            StartTime = $process.StartTime
        }
    }

    # Step 5: Sort and format the report
    $report = $report | Sort-Object -Property CPUUsage -Descending
    $report = $report | Select-Object 'ProcessName', 'MemoryUsage', 'CPUUsage', 'StartTime'

    # Step 6: Calculate and add the RunTimeMinutes property
    foreach ($entry in $report) {
        $entry | Add-Member -MemberType NoteProperty -Name 'RunTimeMinutes' -Value ([int]([datetime]::now - $entry.StartTime).TotalMinutes)
        #$entry.RunTimeHours = [int]([datetime]::now - $entry.StartTime).TotalHours
        #[math]::Round(([DateTime]::Now - $entry.StartTime).TotalMinutes, 2)
    }
    $report = $report | Sort-Object -Property RunTime -Descending

    # Step 7: Export the report to a CSV file
    $report | Export-Csv -Path "process_report.csv" -NoTypeInformation

    # Step 6: Return the report object
    $report
}

# Example usage:
Get-ProcessReport
