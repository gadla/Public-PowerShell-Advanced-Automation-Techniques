# PSLab: Loops and Arrays

### Function structure:

```
function Get-ComputerInfo {
    param(...
}
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