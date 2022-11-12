function Get-Module4 {
    [CmdletBinding( 
        HelpUri ='https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced?view=powershell-5.1',
        PositionalBinding = $false)]

    param(
         [Parameter(HelpMessage = 'Param1 Help Message')]
         [string]
         $param1,
         
         [Parameter(Mandatory = $true,
            HelpMessage = 'Parameter 2 Help Message')]
         [string]
         $param2,

         [switch]
         $param3
    )
    BEGIN {}

    PROCESS {
        Write-Verbose 'Starting function'
        Write-Output "Param1 value is:$param1, Param2 value is: $param2"
        if($param3){
            Write-Output "Param3 is active"
        }
        Write-Debug 'Debug message'
    }

    END {}
}

Get-Module4
Get-Module4 -param2 'Mandatory'
Get-Module4 -param2 'Mandatory' -param1 'param1'
Get-Module4 -param2 'Mandatory' -param3
Get-Module4 -param2 'Mandatory' -Verbose
Get-Module4 -param2 'Mandatory' -Debug
Get-Module4 -param2 'Mandatory' -Verbose -Debug