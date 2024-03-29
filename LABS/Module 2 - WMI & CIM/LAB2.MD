﻿# PSLab: WMI & CIM

## Exercise 1: Querying information by using WMI

```
Go to http://aka.ms/lod
Login with your Microsoft account 
Open LAB 1 and log on to the vm "WIN10 (WDT)"
```



### Task 1: Query IP addresses 

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

### Task 2: Query operating-system version information :


1. To find a repository class that lists operating-system information, type the 
   following command in the Windows PowerShell console, and then press Enter: 
   ```PowerShell
   Get-WmiObject –namespace root\cimv2 –list | Where-Object {$_.Name –like '*operating*'} | Sort Name
   ```
   Notice the Win32_OperatingSystem class
2. To display a list of properties for the class, type the following command in the 
   Windows PowerShell console, and then press Enter: 
   ```PowerShell
   Get-WmiObject –Class 'Win32_OperatingSystem' | Get-Member
   ```
3. Notice the Version, ServicePackMajorVersion, and BuildNumber properties.
4. To display the specified information, type the following command in the 
   Windows PowerShell console, and then press Enter: 
   ```PowerShell
   Get-WmiObject –Class 'Win32_OperatingSystem' | Select-Object -Property Version,ServicePackMajorVersion,BuildNumber
   ```

### Task 3: Query computer-system hardware information :

1. To find a repository class that displays computer-system information, type the 
   following command in the Windows PowerShell console, and then press Enter: 
   ```powershell
   Get-WmiObject –namespace 'root\cimv2' –list | Where-Object {$_.Name –like '*system*'} | Sort Name
   ```
   Notice the Win32_ComputerSystem class.
2. To display a list of instance properties and values, type the following command 
   in the Windows PowerShell console, and then press Enter: 
   ```PowerShell
   Get-WmiObject –class 'Win32_ComputerSystem' | Format-List –Property *
   ```
   Remember that Get-Member does not display property values, but Format-List can.
3. To display the specified information, type the following command in the 
   Windows PowerShell console, and then press Enter:  
   ```PowerShell
   Get-WmiObject –class 'Win32_ComputerSystem' | Select-Object -Property Manufacturer,Model,@{n='RAM';e={$PSItem.TotalPhysicalMemory}}
   Get-WmiObject –class 'Win32_ComputerSystem' | Select-Object -Property Manufacturer,Model,@{n='RAM';e={[int]($PSItem.TotalPhysicalMemory / 1gb)}}
   ```


### Task 4: Query service information :

1. To find a repository class that contains information about services, type the 
   following command in the Windows PowerShell console, and then press Enter: 
   ```PowerShell
   Get-WmiObject –namespace 'root\cimv2' –list | Where-Object {$_.Name –like '*service*'}  | Sort-Object -Property Name
   ```
   Notice the Win32_Service class.
2.  To display a list of instance properties and values, type the following command 
    in the Windows PowerShell console, and then press Enter: 
    ```PowerShell
   Get-WmiObject –Class 'Win32_Service' | Format-List -Property *
   ```
3.  To display the specified information, type the following command in the 
    Windows PowerShell console, and press Enter: 
    ```PowerShell
   Get-WmiObject –Class 'Win32_Service' –Filter "Name LIKE 'S%'" | Select-Object -Property Name,State,StartName
   ```
   Notice the returned list of services that start with the letter S.

### Results: After completing this exercise, you should have queried repository classes by using WMI commands.
---




## Exercise 2: Querying information by using CIM

### Task 1: Query user accounts 


1. To find a repository class that lists user accounts, type the following command 
   in the Windows PowerShell console, and then press Enter: 
   ```PowerShell
   Get-WmiObject –namespace 'root\cimv2' –list | Where-Object {$_.Name –like '*user*'} | Sort-Object -Property Name
   Get-CimClass -Namespace 'root/cimv2' | Where-Object {$_.CimClassName -like '*user*'}  | Sort-Object -Property Name
   Notice the Win32_UserAccount class.

   ```   
2. To display a list of class properties, type the following command in the 
   Windows PowerShell console, and then press Enter: 
   ```PowerShell
   Get-CimInstance –Class 'Win32_UserAccount' | Get-Member
   ```
3. To display the specified information, type the following command in the 
    Windows PowerShell console, and then press Enter: 
    ```PowerShell
   Get-CimInstance –Class 'Win32_UserAccount' | Format-Table –Property Caption,Domain,SID,FullName,Name
    Notice the returned list of all domain and local accounts.
    ```


### Task 2: Query BIOS information 


1. To find a repository class that contains BIOS information, type the following 
   command in the Windows PowerShell console, and then press Enter:
   ```PowerShell
   Get-WmiObject –namespace 'root\cimv2' –list | Where-Object  {$_.Name –like '*bios*'} | Sort-Object -Property Name
   Get-CimClass -Namespace root/cimv2 | Where-Object {$_.CimClassName -like '*bios*'} | Sort-Object -Property Name
   Notice the Win32_BIOS class.
   ```
2. To display the specified information, type the following command in the 
   Windows PowerShell console, and then press Enter: 
   ```PowerShell
   Get-WmiObject -Class 'Win32_BIOS'
   Get-CimInstance –Class 'Win32_BIOS'
   ```

### Task 3: Query network adapter configuration information 


1. To display a list of all the local Win32_NetworkAdapterConfiguration 
   instances, type the following command in the Windows PowerShell console, and then press Enter: 
   ```PowerShell
   Get-CimInstance –Classname 'Win32_NetworkAdapterConfiguration'
   Get-WmiObject -Class 'Win32_NetworkAdapterConfiguration'
   ```
2. To display a list of all the Win32_NetworkAdapterConfiguration instances that exist on MS computer,
   type the following command in the Windows PowerShell console, and then press Enter: 
   ```PowerShell
   Get-CimInstance -Classname 'Win32_NetworkAdapterConfiguration' -ComputerName ms
   Get-WmiObject -Class 'Win32_NetworkAdapterConfiguration' -ComputerName ms
   ```

### Task 4: Query user group information 


1. To find a repository class that lists user groups, type the following command in 
   the Windows PowerShell console, and then press Enter: 
   ```PowerShell
   Get-WmiObject –namespace 'root\cimv2' –list | Where-Object {$_.Name –like '*group*'} | Sort-Object -Property Name
   Get-CimClass -Namespace 'root\cimv2' | Where-Object {$_.CimClassName -like '*group*'} | Sort-Object -Property CimClassName
   Notice the Win32_Group class.
   ```
2. To display the specified information, type the following command in the 
   Windows PowerShell console, and then press Enter: 
   ```PowerShell
   Get-CimInstance –ClassName 'Win32_Group' 
   Get-WmiObject -Class 'Win32_Group'
   ```
3.  Leave the Windows PowerShell console open for the next exercise.

## Results: After completing this exercise, you should have queried repository classes by using CIM commands.



## Exercise 3: Invoking methods

### Task 1: Invoke a CIM method

Connect to aka.ms/lod
Log in and start LAB1
Check the recource tab
Make sure you log in to WIN10

1. To restart MS, type the following command in the Windows PowerShell console, 
   and then press Enter: 
   ```PowerShell
   Invoke-CimMethod –ClassName Win32_OperatingSystem –ComputerName MS –MethodName Reboot
   Notice the response that shows ReturnValue=0 and PSComputerName =MS.
   ```      
2. Switch to the MS(WDT) virtual machine, and see it restarting.


### Task 2: Invoke a WMI method

```PowerShell
Connect to aka.ms/lod
Log in and start LAB1
Check the recource tab
Make sure you log in to WIN10

1. Make sure you are logged on to WIN10
2. Right-click the Start button, and then click Computer Management.
3. Expand Services and Applications, and then click Services.
4. Locate the Windows Remote Management (WS-Management) service, and 
   then note the Startup Type. (The service is also known by the WinRM 
   abbreviation, which is called out in the service description).
5. To change the start mode of the specified service, type the following command 
   in the Windows PowerShell console (Important: make sure that you run PoweShell as Admin), 
   and then press Enter: 
         Get-WmiObject –Class Win32_Service –Filter "Name='WinRM'" | Invoke-WmiMethod –Name ChangeStartMode –Argument 'Automatic'
         Get-CimInstance -ClassName Win32_Service -Filter "Name='WinRM'" | Invoke-CimMethod -Name ChangeStartMode -Arguments @{startmode='Automatic'}
6. Verify that the status of the WinRM service has changed.
   Results: After completing this exercise, you should have used CIM and WMI 
   commands to invoke methods of repository objects.
```