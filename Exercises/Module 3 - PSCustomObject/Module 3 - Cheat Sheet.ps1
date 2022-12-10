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