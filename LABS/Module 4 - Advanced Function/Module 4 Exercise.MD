# PSLab: Advanced Functions

## Excercise instructions

```
Write a fuction that does the following:
1. Supports [Cmdletbinding()]
    1.1 the Cmdletbinding should include HelpURI
    1.1 the Cmdletbinding should include PositionalBinding (Set to $false)
2. Accepts 3 parameters ($Param1, $Param2, $Param3) $param1 and $param2 will be string parameters (strong types)
3. Only Param2 should be mandatory ([Parameter(mandatory)])
4. $Param1 and $Param2 should include help message ([Parameter(HelpMessage = 'Message')])
5. $Param3 should be a switch parameter
6. The function will display the value of $Param1 and $Param2
7. If $param3 is on there will be another message
8. Write a message using Write-verbose
9. Write a message using Write-debug
```

### Function structure:

```
function Get-Module4 {
    param(...
}
```


### Sample outputs: 
#### Notice the Help messafe of Parameter 2

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