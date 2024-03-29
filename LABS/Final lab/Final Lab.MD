﻿# PSLab: Final Lab

## Write a function that does the following:
```

1. Connects to a remote computer(s) and retrieve the following information: 
    1.1 ComputerName
    1.2 BIOS Serial Number           (Hint Win32_BIOS class)
    1.3 Operating System             (Hint Win32_OperatingSystem class)
    1.4 Computer Model               (Hint Win32_ComputerSystem class)
    1.5 Manufacturer                 (Hint Win32_ComputerSystem)
    1.6 Memory (value will be in GB) (Hint Win32_ComputerSystem) 

2. The function will recieve the following parameters:
    2.1 Computername - the name of the computer/computers that the function will connect to This will be a positional parameter (in position 0)
    Make sure that the parameter $ComputerName can accept pipeline parameters (ByValue & ByPropertyName)
    Do not allow null or empty strings (Hint help about_Functions_Advanced_Parameters -ShowWindow)
    2.2 QueryType    - CIM / WMI providers to retrieve information
    This will be a ValidateSet parameter with the values WMI and CIM.

All parameters will be:
    1 Required
    2 Include HelpMessage ([Parameter(HelpMessage='MyMessage')]	  
    3 Use the 

3. The results of the function can be piped to Export-CSV and Out-GridView.

4. The function must include hard type variables.

5. The function must include commented help section with the following elements:
    5.1 .Synopsis
    5.2 Description
    5.3 Parameter (for each of the parameters)
    5.4 Examples
Hint
    (Get-Help About_Comment_Based_Help)

Additional instructions:

1. We assume that all of the remote computers are up and listeners (WMI/CIM) are healthy
2. The function must support [Cmdletbinding()]
	2.1 the Cmdletbinding should include HelpURI
	2.2 the Cmdletbinding should stop PositionalBinding (This is a $True/$False value)
3. The function must display information of Verbose and Debug

```
### Function structure:

```
function Get-FinalExercise {
    param(...
}
```


### Sample outputs: 

```
Get-FinalExercise -ComputerName localhost,127.0.0.1 -QueryType WMI -Verbose

VERBOSE: Query method is WMI

ComputerName     : localhost
BiosSerialNumber : PC2113LH
OperatingSystem  : Microsoft Windows 11 Enterprise
ComputerModel    : 11JKS14K00
Manufacturer     : LENOVO
Memory(GB)       : 15

ComputerName     : 127.0.0.1
BiosSerialNumber : PC2113LH
OperatingSystem  : Microsoft Windows 11 Enterprise
ComputerModel    : 11JKS14K00
Manufacturer     : LENOVO
Memory(GB)       : 15
```

```
Get-FinalExercise -ComputerName localhost,127.0.0.1 -QueryType CIM -Verbose -Debug

*** You should get a debug message ***

VERBOSE: Query method is CIM

ComputerName     : localhost
BiosSerialNumber : PC2113LH
OperatingSystem  : Microsoft Windows 11 Enterprise
ComputerModel    : 11JKS14K00
Manufacturer     : LENOVO
Memory(GB)       : 15

ComputerName     : 127.0.0.1
BiosSerialNumber : PC2113LH
OperatingSystem  : Microsoft Windows 11 Enterprise
ComputerModel    : 11JKS14K00
Manufacturer     : LENOVO
Memory(GB)       : 15
```