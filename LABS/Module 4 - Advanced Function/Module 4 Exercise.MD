# PSLab: Advanced Functions

## Excercise instructions
```
Define an advanced function with the following requirements:
1. Supports [CmdletBinding()]
   - the Cmdletbinding should include HelpURI
   - the Cmdletbinding should include PositionalBinding (Set to $false)

2. Accepts 3 parameters ($Param1, $Param2, $Param3).
   - All parameters should be strong typed.
   - $param1 and $param2 will be string parameters.
   - Only $Param2 should be mandatory ([Parameter(Mandatory = $true)]).
   - $Param1 and $Param2 should include help messages ([Parameter(HelpMessage = 'Message')]).
   - $Param3 should be a switch parameter.

3. Displays the value of $Param1 and $Param2.
4. If $param3 is on, output a message indicating that it is active.
5. Write a message using Write-Verbose to indicate the start of the function.
6. Write a message using Write-Debug to output a debug message.
```


### Function structure:

```
function Get-Module4 {
    param(...
}
```


### Sample outputs: 
#### Notice the Help message of Parameter 2

```
Get-Module4

cmdlet Get-Module4 at command pipeline position 1
Supply values for the following parameters:
(Type !? for Help.)
param2: !?
param2 help message 
param2: Param2
Param1 value is:, Param2 value is: Param2


Get-Module4 -param2 'Mandatory'
Param1 value is:, Param2 value is: Mandatory

Get-Module4 -param2 'Mandatory' -param1 'param1'
Param1 value is:param1, Param2 value is: Mandatory

Get-Module4 -param2 'Mandatory' -param3
Param1 value is:, Param2 value is: Mandatory
Param3 is active


Get-Module4 -param2 'Mandatory' -Verbose
VERBOSE: Starting function
Param1 value is:, Param2 value is: Mandatory
```


### Hints

```
1. Use this command to get help about the [Parameter] attribute
    help about_ | Where-Object {$PSItem.name -like '*adv*param*'}| help -ShowWindow

2. use this command to get help about the [Cmdletbinding] attribute:
    help about_ | Where-Object {$_.name -like '*bindi*'} | help -ShowWindow
```