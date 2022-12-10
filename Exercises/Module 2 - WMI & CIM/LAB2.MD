# PSLab: WMI & CIM

## Exercise 1: Querying information by using WMI

```
Go to http://aka.ms/lod
Login with your Microsoft account 
Open LAB 1 and log on to the vm "WIN10 (WDT)"
```



#### Task 1: Query IP addresses 

```
1. Open PowerShell **as Administrator**
2. To find a repository class that lists the IP addresses being used by a computer, 
   type the following command in the Windows PowerShell console, and then press Enter: 
       **Get-WmiObject –namespace root\cimv2 –list | Where-Object  {$_.Name –like  '*configuration*'} | Sort Name**
   Notice the **Win32_NetworkAdapterConfiguration** class
3. To retrieve all instances of the class showing DHCP IP addresses, type the 
   following command in the Windows PowerShell console, and then press Enter: 
       Get-WmiObject –Class 'Win32_NetworkAdapterConfiguration' | Select-object -Property 'IPAddress' -Unique
   Remember that you can run the first command and pipe its output to Get-Member to see the properties that are available.
```