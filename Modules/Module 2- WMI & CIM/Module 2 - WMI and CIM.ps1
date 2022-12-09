
#region Listing
# Listing Namespaces
Get-WmiObject -Namespace root -List -Recurse | Select-Object -Unique __NAMESPACE 
Get-CimInstance -Namespace Root -ClassName __Namespace
# Write Get-CimInstance -Namespace for intelisense

# Listing classes
Get-WmiObject -Namespace root\cimv2 -List | Sort-Object Name | Select-Object -First 5
Get-CimClass -Namespace root\CIMv2 | Sort-Object CimClassName | Select-Object -First 5
# Notice that Get-WmiObject and Get-CinInstance return a different output
#endregion

# WMI Explorer link
# https://github.com/vinaypamnani/wmie2/releases


#region Querying instances
Get-WmiObject -Class Win32_LogicalDisk
Get-CimInstance -ClassName Win32_LogicalDisk
#Filtering 
Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=3" | format-list
Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" | format-list

# Using Query
Get-WmiObject -Query "SELECT * FROM Win32_LogicalDisk WHERE DriveType = 3"
Get-CimInstance -Query "SELECT * FROM Win32_LogicalDisk WHERE DriveType = 3"


#region connecting to remote computers
Get-WmiObject -ComputerName contoso-dc1 -Class Win32_Bios
Get-WmiObject -ComputerName contoso-dc1 -Class Win32_Bios -Credential contoso\administrator
Get-CimInstance -ComputerName contoso-dc1 -ClassName Win32_Bios
# Notice that you can't commect to remote computers using the CIM .............. REALLY !?!?!?!?!?
# Use INVOKE-COMMAND instead !!!!
#endregion

#region Using CIM Sessions

$session = New-CimSession -ComputerName contoso-dc1
Get-CimInstance -CimSession $session -ClassName Win32_Bios
$session.Close()
#------------------------------------------------------------------------------------------
#using Credentials with CIM Sessions
$session = New-CimSession -ComputerName contoso-dc1 -Credential contoso\administrator
Get-CimInstance -CimSession $session -ClassName Win32_Bios
$session.Close()

#endregion

#region discovering Methods
Get-WmiObject -Class win32_service | Get-Member -MemberType Method
Get-CimClass -ClassName Win32_Service | Select-Object -ExpandProperty cimClassMethods
#endregion

#region Invoking CIM/WMI Methods
<#-------------------------------------------------------------------------------------------------------------
Using WMI
-------------------------------------------------------------------------------------------------------------#>
#First way
Get-Service -Name Spooler -ComputerName contoso-aad | Select-Object status,name,displayname,StartType
Get-WmiObject -ComputerName contoso-aad -Class win32_service | Where-Object {$_.name -eq 'Spooler'} |
    Invoke-WmiMethod -Name ChangeStartMode -ArgumentList 'Manual'
Get-Service -Name Spooler -ComputerName contoso-aad | Select-Object status,name,displayname,StartType
Get-WmiObject -ComputerName contoso-aad -Class win32_service | Where-Object {$_.name -eq 'Spooler'} |
    Invoke-WmiMethod -Name ChangeStartMode -ArgumentList 'Automatic'
Get-Service -Name Spooler -ComputerName contoso-aad | Select-Object status,name,displayname,StartType

#Second way
Get-Service -Name Spooler -ComputerName contoso-aad | Select-Object status,name,displayname,StartType
$spoolerService = Get-WmiObject -Class win32_service -Namespace root\cimv2 -ComputerName contoso-aad | Where-Object {$_.name -eq 'Spooler'}
$return = $spoolerService.ChangeStartMode('Manual')
if($return.returnvalue -eq 0) { Write-Output 'success' }
else
    {Write-Output " $($return.returnvalue) was reported!" }
Get-Service -Name Spooler -ComputerName contoso-aad | Select-Object status,name,displayname,StartType

<#-------------------------------------------------------------------------------------------------------------
Using CIM
-------------------------------------------------------------------------------------------------------------#>
Get-Service -Name Spooler -ComputerName contoso-aad | Select-Object status,name,displayname,StartType
Get-CimInstance -ComputerName contoso-aad -ClassName win32_service -Filter "Name='Spooler'" |
    Invoke-CimMethod -MethodName ChangeStartMode -Arguments @{startmode='Automatic'}
#endregion













#Using a normal command
Get-CimInstance  -ClassName Win32_LogicalDisk |
    Where-Object {$_.DriveType -eq 3} |
    Select-Object SystemName,Size,FreeSpace

#Modifying attributes
Get-CimInstance  -ClassName Win32_LogicalDisk |
    Where-Object {$_.DriveType -eq 3} |
    Select-Object -Property @{Name='ComputerName';Expression={$_.SystemName}},
        @{Name='Size (GB)';Expression={$_.Size /1GB -as [int]}},
        @{n='FreeSpace (GB)';e={$_.FreeSpace /1GB -as [int]}}

#Setting the command as a function
function Get-CimDisk {
    Get-CimInstance -ClassName Win32_LogicalDisk |
        Select-Object -Property @{Name = 'ComputerName';Expression = {$_.SystemName}},
            @{Name = 'Disk Name';Expression ={$_.DeviceID}},
            @{Name = 'Size(GB)';Expression={$_.Size/1GB -as [int]}},
            @{Name = 'FreeSpace(GB)';Expression = {$_.FreeSpace/1gb -as [int]}}
}

#Setting the command as a function with parameters
function Get-CimDiskWithParam {
    param (
        [string]$ComputerName = 'Contoso-Win10',
        [int]$DriveType = 3
    )
    Get-CimInstance -ClassName Win32_LogicalDisk |
        Select-Object -Property @{Name = 'ComputerName';Expression = {$ComputerName}},
            @{Name = 'Disk Name';Expression ={$_.DeviceID}},
            @{Name = 'Size(GB)';Expression={$_.Size/1GB -as [int]}},
            @{Name = 'FreeSpace(GB)';Expression = {$_.FreeSpace/1gb -as [int]}}
}

#Setting parameters 
# We can use types of parameters in order to custom our parameters
function Get-CimDiskWithParam {
    param (
        # ComputerName Provide FQDN name
        [parameter(
            Mandatory=$true, 
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true, 
            ValueFromRemainingArguments=$false, 
            Position=0
        )]
        [ValidateNotNullOrEmpty()]
        [string]$ComputerName,


        [int]$DriveType = 3
    )
    Get-CimInstance -ClassName Win32_LogicalDisk |
        Select-Object -Property @{Name = 'ComputerName';Expression = {$ComputerName}},
            @{Name = 'Disk Name';Expression ={$_.DeviceID}},
            @{Name = 'Size(GB)';Expression={$_.Size/1GB -as [int]}},
            @{Name = 'FreeSpace(GB)';Expression = {$_.FreeSpace/1gb -as [int]}}
}
