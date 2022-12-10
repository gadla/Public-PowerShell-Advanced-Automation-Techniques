# PSLab: WMI & CIM

## Exercise 1: Querying information by using WMI

```
Go to http://aka.ms/lod
Login with your Microsoft account 
Open LAB 1 and log on to the vm "WIN10 (WDT)"
```



### Sample outputs: 

```
Get-ComputerInfo

ComputerName     : STUDYROOM
BiosSerialNumber : PC2113LH
OperatingSystem  : Microsoft Windows 11 Enterprise
ComputerModel    : 11JKS14K00
Memory(GB)       : 15


Get-ComputerInfo | Out-GridView

Get-ComputerInfo | Export-Csv -Path MyPath -NoTypeInformation
```