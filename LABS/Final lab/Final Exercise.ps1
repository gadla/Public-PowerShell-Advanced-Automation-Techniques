function Get-FinalExercise {
    <#
        .SYNOPSIS
        This function will retrieve management information from remote computers
        
        .DESCRIPTION
        This function will retrieve management information from remote computers.
        The function will use the WMI or the CIM in order to retrieve the information.
        You need to have the appropriate permissions in order to retrieve the information.
        We assume that there is no firewall and the listener (WMI/CIM) is up and healthy on the remote computers.

        .PARAMETER ComputerName
        Specifies the target computer for the management operation. Enter a fully qualified domain name (FQDN), a NetBIOS name, or an IP address. 
        When the remote computer is in a different domain than the local computer, the fully qualified domain name is required.

        Get-MyInfo -ComputerName LocalHost -QueryType WMI
        Get-MyInfo -ComputerName LocalHost -QueryType CIM

        .PARAMETER QureyType
        Specifies the underlying technology being used.
        
        When using WMI you need the following ports opened:
        TCP 135, TCP 49152 - 65535

        When using CIM you need the following prerequisites:
        TCP 5985/5986 opened.
        Windows Remote Management (Win-RM) service activated and configured

        .EXAMPLE
         Get-MyInfo -ComputerName LocalHost,MyPC -QueryType WMI
        
        .EXAMPLE
         Get-MyInfo -ComputerName LocalHost,MyPC -QueryType CIM
    #>
    [CmdletBinding(
        HelpUri = 'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_cmdletbindingattribute?view=powershell-5.1',
        PositionalBinding = $false)]
    param(
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $ComputerName,

        [Parameter(Mandatory = $true)]
        [ValidateSet('WMI','CIM')]
        [string]
        $QueryType
    )

    BEGIN {
        Write-Verbose "Query method is $QueryType"
        Write-Debug 'Debug mode is on'
    }

    PROCESS {
        

        foreach ($computer in $ComputerName) {
            if ($QueryType -eq 'WMI') {
                $Bios = Get-WmiObject -Class Win32_BIOS -ComputerName $computer
                $Os = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $computer
                $Cs = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $computer
            } else {
                $PSSession = New-PSSession -ComputerName $computer
                $Bios = invoke-command -scriptblock {Get-CimInstance -ClassName Win32_BIOS} -Session $PSSession 
                $Os = invoke-command -scriptblock {Get-CimInstance -ClassName Win32_OperatingSystem} -Session $PSSession
                $Cs = invoke-command -scriptblock {Get-CimInstance -ClassName Win32_ComputerSystem} -Session $PSSession
                Remove-PSSession -Id $PSSession.Id
            }

            $Results = [pscustomobject]@{
                'ComputerName'     = $computer
                'BiosSerialNumber' = $Bios.SerialNumber
                'OperatingSystem'  = $Os.Caption 
                'ComputerModel'    = $Cs.Model
                'Manufacturer'     = $Cs.Manufacturer
                'Memory(GB)'       = ([int]($Cs.TotalPhysicalMemory /1gb))
            }

            Write-Output $Results
        }
    }

    END {}
}

Get-FinalExercise -ComputerName localhost,127.0.0.1 -QueryType WMI -Verbose
Get-FinalExercise -ComputerName localhost,127.0.0.1 -QueryType CIM -Verbose -Debug
