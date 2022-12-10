# PSLab: WMI & CIM

## Exercise 1: Querying information by using WMI

```
Go to http://aka.ms/lod
Login with your Microsoft account 
Open LAB 1 and log on to the vm "WIN10 (WDT)"
```



#### Task 1: Query IP addresses 

```
1. Open PowerShell as Administrator
2. To find a repository class that lists the IP addresses being used by a computer, 
   type the following command in the Windows PowerShell console, and then press Enter: 
       Get-WmiObject –namespace root\cimv2 –list | Where-Object  {$_.Name –like  '*configuration*'} | Sort Name
   Notice the Win32_NetworkAdapterConfiguration class
3. To retrieve all instances of the class showing DHCP IP addresses, type the 
   following command in the Windows PowerShell console, and then press Enter: 
       Get-WmiObject –Class 'Win32_NetworkAdapterConfiguration' | Select-object -Property 'IPAddress' -Unique
   Remember that you can run the first command and pipe its output to Get-Member to see the properties that are available.
```

#### Task 2: Query operating-system version information 

```
1. To find a repository class that lists operating-system information, type the 
   following command in the Windows PowerShell console, and then press Enter: 
         Get-WmiObject –namespace root\cimv2 –list | Where-Object {$_.Name –like '*operating*'} | Sort Name
   Notice the Win32_OperatingSystem class
2. To display a list of properties for the class, type the following command in the 
   Windows PowerShell console, and then press Enter: 
         Get-WmiObject –Class 'Win32_OperatingSystem' | Get-Member
3. Notice the Version, ServicePackMajorVersion, and BuildNumber properties.
4. To display the specified information, type the following command in the 
   Windows PowerShell console, and then press Enter: 
         Get-WmiObject –Class 'Win32_OperatingSystem' | Select-Object -Property Version,ServicePackMajorVersion,BuildNumber
```

#### Task 3: Query computer-system hardware information 

```
1. To find a repository class that displays computer-system information, type the 
   following command in the Windows PowerShell console, and then press Enter: 
         Get-WmiObject –namespace 'root\cimv2' –list | Where-Object {$_.Name –like '*system*'} | Sort Name
   Notice the Win32_ComputerSystem class.
2. To display a list of instance properties and values, type the following command 
   in the Windows PowerShell console, and then press Enter: 
         Get-WmiObject –class 'Win32_ComputerSystem' | Format-List –Property *
   Remember that Get-Member does not display property values, but Format-List can.
3. To display the specified information, type the following command in the 
   Windows PowerShell console, and then press Enter:  
         Get-WmiObject –class 'Win32_ComputerSystem' | Select-Object -Property Manufacturer,Model,@{n='RAM';e={$PSItem.TotalPhysicalMemory}}
         Get-WmiObject –class 'Win32_ComputerSystem' | Select-Object -Property Manufacturer,Model,@{n='RAM';e={[int]($PSItem.TotalPhysicalMemory / 1gb)}}
```