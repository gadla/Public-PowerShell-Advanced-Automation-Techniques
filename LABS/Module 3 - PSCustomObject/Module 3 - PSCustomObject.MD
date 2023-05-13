# PSLab: PSCustomObject
### **Excersise 1:**
### Function structure:

```PowerShell
function Get-ComputerInfo {
    param(...
}
```


### Sample outputs: 

```PowerShell
Get-ComputerInfo

ComputerName     : STUDYROOM
BiosSerialNumber : PC2113LH
OperatingSystem  : Microsoft Windows 11 Enterprise
ComputerModel    : 11JKS14K00
Memory(GB)       : 15


Get-ComputerInfo | Out-GridView

Get-ComputerInfo | Export-Csv -Path MyPath -NoTypeInformation
```


### **Excersise 2:**
### Function structure:

```PowerShell
function Get-ProcessReport {
    param(...
}
```


### Sample outputs: 

```PowerShell
PS C:\PoweShell> C:\temp\PsCustomObject_Excercise2.ps1


ProcessName    : explorer
MemoryUsage    : 587264000
CPUUsage       : 32
StartTime      : 08/05/2023 15:11:51
RunTimeMinutes : 12

ProcessName    : igfxEMN
MemoryUsage    : 17313792
CPUUsage       : 1
StartTime      : 08/05/2023 15:11:51
RunTimeMinutes : 12

There is also a CSV file created in the same folder as the script.
```


**Exercise 2:** 
Creating a PowerShell script that generates a report on running processes on a Windows computer

In this exercise, you will create a PowerShell script that generates a report on running processes on a Windows computer. The script will use PSCustomObjects to store and manipulate data, and it will consist of multiple steps, each building on top of the previous one.

*Step 1:*
* Open PowerShell ISE as an administrator.
* Make sure that your .ps1 file uses the #Requires statement to specify that the script requires to run as Administrator.

*Step 2:*
* Get the current logged on user (use the `$env:USERNAME` automatic variable) and store the result in a * variable called `$user`.

*Step 3:*
* Use the `Get-Process` cmdlet to retrieve a list of running processes on the computer. 
* Select only the processes that are running in the context of the user (use the -IncludeUserName parameter) and store the results in a variable called `$processes`.

*Step 4:*
* Create a PSCustomObject `$report` that has the following properties: `ProcessName`, `MemoryUsage`, `CPUUsage`, and `StartTime`. 
* For each process in `$processes`, retrieve the process name, memory usage, CPU usage, and start time, and store the results in the corresponding properties of the `$report` object.
* Round up the `MemoryUsage` and `CPUUsage` properties to the next integer (use **[math]::Ceiling()** static function to do so).

Step 5:
* Sort the `$report` object by the `CPUUsage` property in descending order. 
* Use the `Select-Object` cmdlet to display the `$report` object in a user-friendly format, showing only the `ProcessName`, `MemoryUsage`, and `CPUUsage` properties.

Step 6:
* For each process in `$report`, add a new property named `RunTimeHours` and calculate the number of minutes that have elapsed since the process was started. 
* Round up the result to the next integer (use **[math]::Ceiling()** static function to do so).
* Sort the `$report` object by the `RunTime` property in descending order.

Step 7:
Use the `Export-Csv` cmdlet to save the `$report` object to a CSV file. Include the `ProcessName`, `MemoryUsage`, `CPUUsage`, and `RunTime` properties.



This exercise requires you to use PSCustomObjects to store and manipulate data, and to use multiple steps to build a comprehensive report on running processes on a Windows computer. By breaking the problem down into smaller steps and building on the results of previous steps, you can create a script that is flexible, efficient, and easy to maintain.
