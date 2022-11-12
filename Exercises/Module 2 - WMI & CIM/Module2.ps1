# WMI

$Bios = Get-WmiObject -Class Win32_BIOS
Write-Output $Bios.SerialNumber

$Os = Get-WmiObject -Class Win32_OperatingSystem
Write-Output $Os.Caption

$Cs = Get-WmiObject -Class Win32_ComputerSystem
Write-Output $Cs.Model
Write-Output $Cs.Manufacturer
Write-Output $Cs.TotalPhysicalMemory
Write-Output ($Cs.TotalPhysicalMemory /1gb)
Write-Output ([int]($Cs.TotalPhysicalMemory /1gb ))

# CIM

$CimBios = Get-CimInstance -ClassName Win32_BIOS
Write-Output $CimBios.SerialNumber

$CimOs = Get-CimInstance -ClassName Win32_OperatingSystem
Write-Output $CimOs.Caption

$CimCs = Get-CimInstance -ClassName Win32_ComputerSystem
Write-Output $CimCs.Model
Write-Output $CimCs.Manufacturer
Write-Output $CimCs.TotalPhysicalMemory
Write-Output ($CimCs.TotalPhysicalMemory /1gb)
Write-Output ([int]($CimCs.TotalPhysicalMemory /1gb))