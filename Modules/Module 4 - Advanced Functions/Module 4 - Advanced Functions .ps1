<#######################################################################
########################################################################
Functions Recap
########################################################################
########################################################################>

    #region simple function    
    function Get-DemoFunction {
        Write-Output "This is a demo function"
    }
    Get-DemoFunction
    #endregion

    #region function with parameters
    function Get-FunctionWithParameters {
        param (
            [int]$param1,
            [string]$param2
        )
        Write-Output "Parameters accepted are $param1 and $param2"
    }
    Get-FunctionWithParameters -param1 34 -param2 'String Parameter'
    Get-FunctionWithParameters -param1 43 -param2 23
    #look that param2 casted the 23 to string
    Get-FunctionWithParameters -param1 'string' -param2 'string2'
    #look at the error that we are getting here, it states that 'param1' can't convert "string" to int
    #endregion

    #region parameters with default values
    function Get-ParameterWithDefaultValue {
        param (
            [string]$Name = 'Gadi'
        )
        Write-Output "Hello, my name is: $Name"
    }
    Get-ParameterWithDefaultValue
    Get-ParameterWithDefaultValue -Name 'Ben'
    #endregion

<#######################################################################
########################################################################
END Functions Recap
########################################################################
########################################################################>






<#######################################################################
########################################################################
Starging Scopes
########################################################################
########################################################################>
#region scopes

    Write-Output "Defining Scopes"

    #region Accessing global variables
    $x = 50
    function Access-GlobalVariable {
        $x = 100
        Write-Output "`$x variable (inside the function) is: $x"
        Write-Output "`$x variable (Outside the function) is: $global:x"
    }
    Access-GlobalVariable

    #endregion


    #region Defining Scopes
        #in the console
        $x = 100

        #in the script
        Write-Output "within the script"
        Write-Output "value of x is: $x"
        Write-Output "Changing the value of x in the script"
        $x = 200
        Write-Output "value of x is: $x"
        function foo {
            Write-Output "Within the function"
            Write-Output "value of x is: $x"
            Write-Output "Changing the value of x in the function"
            $x = 300
            Write-Output "value of x is: $x"
        }
        foo
        Write-Output "Within the function again"
        Write-Output "value of x is: $x"
    #endregion

    #region Changing variables from other scopes
        #in the console
        $x = 100

        #in the script
        Write-Output "value of x is: $x"
        Set-Variable -Name x -Scope global -Value 500
        Write-Output "value of x is: $x"
        function foo {
            Write-Output "value of x is: $x"
            $x = 300
            Write-Output "value of x is: $x"
        }
        foo
        Write-Output "value of x is: $x"
    #endregion

#endregion

<#######################################################################
########################################################################
Ending Scopes
########################################################################
########################################################################>




<#######################################################################
########################################################################
Parameters Basic 
########################################################################
########################################################################>

#region Parameters Basic
    #region Parameters - No Param() statement
    function Get-FunctionWithoutParamStatement ($p1,$p2,$p3) {
        Write-Output "First parameter is:$p1, second parameter is:$p2, third parameter is:$p3"        
    }
    Get-FunctionWithoutParamStatement -p1 'First' -p3 'Third' -p2 'Second'
    Get-FunctionWithoutParamStatement -p1 'Just this one'
    #endregion


    #region Parameters - Param() statement

    function Get-FunctionWithParamStatement {
        param(
            $p1,
            $p2,
            $p3
        )
        Write-Output "First parameter is:$p1, second parameter is:$p2, third parameter is:$p3"        
    }
    Get-FunctionWithParamStatement -p1 'First' -p3 'Third' -p2 'Second'
    Get-FunctionWithParamStatement -p1 'Just this one'

    function Get-FunctionParameterDefaultValue {
        param(
            $name = 'Gadi'
        )
        Write-Output "Hello $name"
    }
    Get-FunctionParameterDefaultValue
    Get-FunctionParameterDefaultValue -name 'Ben'


    function Get-FunctionParameterStrongType {
        param(
            [string]$name = "Gadi",
            [int]$age     = 48
        )
        Write-Output "Hello $name, your age is $age"
    }
    Get-FunctionParameterStrongType -name 'Moshe' -age 32
    Get-FunctionParameterStrongType -age 33 # hmmm, why did this work ???????
    Get-FunctionParameterStrongType -name 32 -age 'Moshe'
    #endregion

    #region using $args
    # This is possible but I don't recommend it! Allways be super explicit
    function Use-Args {
        write-output "$($args[0]) $($args[1])"
    }
    Use-Args Hello World

    #second example
    function Add-Numbers {
        $sum = 0
        foreach ($arg in $args){
            $sum += $arg
        }
        Write-Output $sum
    }
    Add-Numbers 45 76 89 23 74
    #endregion

    #region $PSBoundParameters
    function Get-PSBoundParameters {
        param (
        [int]$param1,
        [string]$param2
        )
        Write-Output "Parameters accepted are $param1 and $param2"
        Write-Output $PSBoundParameters
    }
    Get-PSBoundParameters -param1 40 -param2 'text'
        
    #endregion

    #region Named Parameters with $args
    
    function Get-NamedParametersWithArgs{
        param(
            [string]$name
        )
        Write-Output "Your name is:$name"
        Write-Output $args
    }
    Get-NamedParametersWithArgs -name 'Gadi'
    Get-NamedParametersWithArgs -name 'Gadi' ,34,'text'
    #endregion

#endregion

<#######################################################################
########################################################################
END Parameters Basic 
########################################################################
########################################################################>









<#######################################################################
########################################################################
Switch Parameter 
########################################################################
########################################################################>

#region Switch Parameter
    function SwitchExample {
        Param([switch]$state)
        if ($state) {"Power is on"} else {"Switch is off"}
    }
    SwitchExample
    SwitchExample -state
    SwitchExample -state:$false
    SwitchExample -state:$true
#endregion

<#######################################################################
########################################################################
END Switch Parameter 
########################################################################
########################################################################>









<#######################################################################
########################################################################
The Parameter Attribute
########################################################################
########################################################################>

#region Parameter attribute
    #Mandatory Parameter
        function Get-MandatoryParameter {
            Param(
                [Parameter(Mandatory)]
                [string[]]
                $ComputerName
            )
            Write-Output "Computer name passed is: $ComputerName"
        }
        Get-MandatoryParameter -ComputerName "MyComputer"
        Get-MandatoryParameter
        
        #region Positional Parameter
        function Get-PositionalParameter {
            Param(
                [string]
                $param1,

                [Parameter(Position=0)]
                [string[]]
                $ComputerName
            )
            Write-Output "Computer name passed is: $ComputerName, Param1 parameter is:$param1"
        }
        Get-PositionalParameter -ComputerName "MyComputer" -param1 'Nothing'
        Get-PositionalParameter "MyComputer" -param1 'Nothing'
        Get-PositionalParameter -param1 'Nothing' "MyComputer"
        #endregion
        
        #region ParameterSetName
        function Get-MultipleParameterSets {
            Param(
                [Parameter(Mandatory,
                ParameterSetName="Computer")]
                [string[]]
                $ComputerName,
                [Parameter(Mandatory,
                ParameterSetName="User")]
                [string[]]
                $UserName,
                [Parameter()]
                [switch]
                $Summary
            )
        }
        Get-Help Get-MultipleParameterSets
        #endregion

        #region ValueFromPipeline argument
        function Get-ValueFromPipeline{
            Param(
                [Parameter(Mandatory,
                ValueFromPipeline)]
                [string[]]
                $ComputerName
            )
            Write-Output "Computer name passed is: $ComputerName"
        }
        'MyComputer' | Get-ValueFromPipeline
        #endregion

        #region ValueFromPipelineByPropertyName argument
        function Get-ValueFromPipelineByPropertyName{
            param (
                [Parameter(Mandatory,
                ValueFromPipelineByPropertyName)]
                [string[]]
                $ComputerName
            )
            Write-Output "Computer name passed is: $ComputerName"
        }
        Get-Help Get-ValueFromPipelineByPropertyName -Parameter ComputerName
        'MyComputer' | Get-ValueFromPipelineByPropertyName
        $MyComputer = [PSCustomObject]@{
            ComputerName = 'MyComputer'
        }
        $MyComputer | Get-ValueFromPipelineByPropertyName
        #endregion

        #region HelpMessage argument
        function Get-HelpMessage {
            Param(
                [Parameter(Mandatory,
                    HelpMessage = 'Enter computer name')]
                [string]
                $ComputerName
            )
        }
        Get-Help Get-HelpMessage -Parameter computername
        Get-HelpMessage #in the parameter input type !?
        #endregion

        #region Alias attribute
        function Get-AliasParameter{
            param (
                [Parameter(Mandatory,
                ValueFromPipelineByPropertyName)]
                [Alias('cn','MachineName')]
                [string[]]
                $ComputerName
            )
            Write-Output "Computer name passed is: $ComputerName"
        }
        $MyPC = [PSCustomObject]@{
            ComputerName = 'MyComputer'
        }
        $MyPC | Get-AliasParameter
        $MySecondPC = [PSCustomObject]@{
            cn = 'MySecondComputer'
        }
        $MySecondPC | Get-AliasParameter
        $MyThirdPC = [PSCustomObject]@{
            MachineName = 'MyThirdComputer'
        }
        $MyThirdPC | Get-AliasParameter
        #endregion
    
#endregion

<#######################################################################
########################################################################
END Parameter attribute 
########################################################################
########################################################################>






<#######################################################################
########################################################################
Parameter Advanced attributes and Vadilators
########################################################################
########################################################################>

#region Parameter validators
Write-Output 'What are Parameter Validators?'

   
        #region AllowNull/AllowEmptyString/AllowEmptyCollection
        function Get-AllowNull{
            Param(
                [Parameter(Mandatory)]
                [AllowNull()]
                [hashtable]
                $ComputerInfo
            )
            Write-Output $ComputerInfo    
        }
        Get-AllowNull -ComputerInfo $null
        Get-AllowNull -ComputerInfo @{'value' = 1}
        #endregion

        #region ValidateNotNullOrEmpty/ValidateNotNull
        function Get-ValidateNotNullOrEmpty {
            Param(
                [Parameter(Mandatory)]
                [ValidateNotNullOrEmpty()]
                [string[]]
                $UserName
            )
            Write-Output $username
        }
        Get-ValidateNotNullOrEmpty -UserName 'Gadi'
        Get-ValidateNotNullOrEmpty -UserName ''
        Get-ValidateNotNullOrEmpty -UserName $null
        #endregion

        #region ValicateCount validation attribute
        function Get-ValidateCount {
            Param(
                [Parameter(Mandatory)]
                [Validatecount(2,3)]
                [string[]]
                $ComputerName
            )
            Write-Output $ComputerName
        }
        Get-ValidateCount -ComputerName pc1,pc2,pc3
        Get-ValidateCount -ComputerName pc1
        Get-ValidateCount -ComputerName pc1,pc2,pc3,pc4
        #endregion

        #region ValidateScript valication attribute
        function Get-SodaPrice {
            param (
                [Parameter(Mandatory)]
                [ValidateScript({$_ -le 20})]
                $SodaPrice
            )
            Write-Output "Soda price is: $SodaPrice"
        }
        Get-SodaPrice -SodaPrice 10
        Get-SodaPrice -SodaPrice 20
        Get-SodaPrice -SodaPrice 30
        
        #More complex ValidateScript example

        Function Stop-MyService {
            [CmdletBinding()]
            param (
                [parameter(Mandatory)]
                [ValidateScript(
                    {
                        if (Get-Service -Name $_) {
                            $true
                        }
                        else {
                            throw "A service with name $_ is not found."
                        }
                    }
                )]
                [string]$Name
            )
            process {
                Write-Output "Stopping Service: $Name"
                Stop-Service -Name $Name -Force -ErrorAction SilentlyContinue
            }
        }
        
        Stop-MyService -Name 'BITS'
        Stop-MyService -Name 'NonExistingService'

        #endregion

        #region ValidateSet Validation attribute
        function Get-ValidateSet {
            Param(
                [Parameter(Mandatory)]
                [ValidateSet("Low", "Average", "High")]
                [string[]]
                $Detail
            )
            Write-Output $Detail
        }
        Get-ValidateSet -Detail 'Average'
        Get-ValidateSet -Detail 'DoesNotExistOption'
        #endregion
#endregion

<#######################################################################
########################################################################
END Parameter Advanced attributes and Vadilators
########################################################################
########################################################################>



<#######################################################################
########################################################################
Parameter CmdletBinding
########################################################################
########################################################################>

#region [CmdletBinding()]
Write-Output 'What is [CmdletBinding()] and why do I need it?'

    #region Demo Parameter Failure

    # Normal function !!!!!!!! 
    # THIS SHOULD WORK !!!!
    Function Demo-ParameterFailure {
        param ([string]$param1)
        Write-Output "Parameter passed is $param1"
    }
    Demo-ParameterFailure -param1 'a'
    Demo-ParameterFailure -param1 'a' -NotExsistingParam 'Fantasy'

    #Now adding CmdletBinding
    Function Demo-ParameterFailure2 {
        [CmdletBinding()]
        param ([string]$param1)
        Write-Output "Parameter passed is $param1"
    }
    Demo-ParameterFailure2 -param1 'a'
    Demo-ParameterFailure2 -param1 'a' -NotExsistingParam 'Fantasy'

    #endregion

    #region Demo $PSCmdlet
    function Get-PSCmdlet {
        [CmdletBinding()]
        param (
                [string]$param1,
                [Switch]$showPSCmdletVariable
        )
        Write-Output $PSCmdlet.Host
        if($showPSCmdletVariable){
            Write-Output "$($pscmdlet | get-member | Out-GridView)"
        }
    }
    Get-PSCmdlet -param1 'Value'
    Get-PSCmdlet -showPSCmdletVariable
    #endregion

    #region Demo  $PSCmdlet Turn Off positional binding
    function Stop-PositionalBinding {
        [CmdletBinding(PositionalBinding=$false)] #for the demo change to false/true
        param(
            [string]
            $param1)
        Write-Output "Param1 value is:$param1"
    }
    Stop-PositionalBinding -param1 'Value'
    Stop-PositionalBinding 'Value'
    #endregion

    #region common parameters

    function Without-CommonParameters{
        param (
            [string]
            $Message
        )
        Write-Output "Message is: $message"
        Write-Verbose "Verbosing here"
    }
    Without-CommonParameters -Message "My Message"
    Without-CommonParameters -Message "My Message" -Verbose

    function With-CommonParameters{
        [CmdletBinding()]
        param (
            [string]
            $message
        )
        Write-Output "Message is: $message"
        Write-Verbose "Verbosing here"
    }
    With-CommonParameters -message "My message"
    With-CommonParameters -message "My message" -Verbose
    # You cal see all of the common parameters with intelisense 
    
    #endregion


    
    #region SupportShoudProcess
    New-Item -Path 'C:\temp' -Name 'File.csv' -ItemType File
    function Test-ShouldProcess {
        [CmdletBinding(SupportsShouldProcess)]
        param()
        Remove-Item 'C:\temp\File.csv'
    }
    Test-ShouldProcess -WhatIf

    #complete example THIS IS HOW YOU SHOULD WRITE
    function Test-ShouldProcess2 {
        [CmdletBinding(SupportsShouldProcess)]
        param()
        $file = Get-Item 'C:\temp\File.csv'
        if($PSCmdlet.ShouldProcess($file.Name)){
            $file.Delete()
        }
    }
    
    Test-ShouldProcess2 -WhatIf
    Test-ShouldProcess2
    #endregion 

    #region ConfirmImpact
    function Test-ShouldProcessWithConfirmImpact {
        [CmdletBinding(
            SupportsShouldProcess,
            ConfirmImpact = 'High'
        )]
        param()
    
        if ($PSCmdlet.ShouldProcess('TARGET')){
            Write-Output "Some Action"
        }
    }
    Test-ShouldProcessWithConfirmImpact
    #endregion

    #region HelpURI
    function Get-HelpURI {
        [CmdletBinding(HelpURI='https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_cmdletbindingattribute?view=powershell-7.2#syntax')]
        param()
        Write-Output 'Some Action'
    }
    Get-Help Get-HelpURI -Online
    #endregion
#region 
#endregion


<#######################################################################
########################################################################
END Cmdletbinding
########################################################################
########################################################################>


#region Streams

<#######################################################################
#################    Start OF STREAMS  #################################
#######################################################################>
Write-Output 'Streams'
#region Output Stream

function Get-OutputStream {
    Write-Output 'Output stream from Get-OutputStream function'
    'Second line from Get-OutputStream function'
}
Get-OutputStream
$output = Get-OutputStream
$output

#endregion

#region Error Stream
function Get-ErrorStream {
    Write-Error -Message 'Error message from Get-ErrorStream function' -ErrorId 1
    Write-Output 'Output from Get-ErrorStream function'   
    # Write-Error -Message 'Terminating Error from Get-ErrorStream function' -ErrorAction Stop
    # Write-Output 'This line will never show up' 
}
Get-ErrorStream
#remove the remarks from the Get-ErrorStream function and run again
Get-ErrorStream

#endregion

#region Warning Stream
function Get-WarningStream {
    write-warning -Message 'Warning message from Get-WarningStream function'
    Write-Output 'Output from Get-WarningStream function'
}
Get-WarningStream

#endregion

#region Verbose Stream
# This is not working intesionally, to clarify that the verbose stream is added 
# after you use the [CmdletBinding()] inside the function
function Get-VerboseStream {
    Write-Verbose -Message 'Verbose message from Get-VerboseStream function'
}
Get-VerboseStream -Verbose

function Get-VerboseStream {
    [CmdletBinding()]
    param()
    Write-Verbose -Message 'Verbose message from Get-VerboseStream function'
}
Get-VerboseStream -Verbose

#endregion

#region Debug Stream
# This is not working intesionally, to clarify that the Debug stream is added 
# after you use the [CmdletBinding()] inside the function
function Get-DebugStream {
    Write-Debug -Message 'Verbose message from Get-VerboseStream function'
}
Get-VerboseStream -Debug

function Get-DebugStream {
    [CmdletBinding()]
    param()
    Write-Debug -Message 'Verbose message from Get-VerboseStream function'
}
Get-DebugStream -Debug
#endregion

#region Information Stream
# This is not working intesionally, to clarify that the Information stream is added 
# after you use the [CmdletBinding()] inside the function
function Get-InformationStream {
    Write-Information -MessageData 'Information message from Get-Information function'
}
Get-InformationStream -InformationVariable info
$info

function Get-InformationStream {
    [CmdletBinding()]
    param()
    Write-Information -MessageData 'Information message from Get-Information function'
}
Get-InformationStream -InformationVariable info
$info
#endregion


<#######################################################################
#################    END OF STREAMS  ###################################
#######################################################################>



<#######################################################################
#################    Write-Host kills puppies !!  ######################
#######################################################################>

Write-Output 'Write-Host VS. Write-Output'

function Get-WriteHost {
    Write-Host 'Write-host'
    Write-Output 'Write-Output'        
}
Get-WriteHost
$MyOutput = Get-WriteHost
$MyOutput

#endregion