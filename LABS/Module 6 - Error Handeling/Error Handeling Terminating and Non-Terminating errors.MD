# Lab Exercise: Handling Errors Terminating and Non-Terminating errors

## Objective
In this exercise lab, we will explore the concepts of error handling in PowerShell, including Terminating vs. Non-Terminating errors, ErrorRecord Object and the $Error variable, working with -ErrorAction common parameter, $ErrorActionPreference, and $Error variable.

---
## Exercise 1: Terminating vs. Non-Terminating errors

1. Open the PowerShell ISE or any PowerShell editor of your choice.
2. Copy and paste the following code into the editor (use the "Copy" button below):

```powershell
#region Terminating vs. Non-Terminating errors

New-Item -Path c:\temp -Name ErrorHandeling1.txt
New-Item -Path c:\temp -Name ErrorHandeling2.txt

New-Item -Path c:\temp -Name ErrorHandeling1.txt
remove-item 'c:\temp\ErrorHandeling1.txt'
Remove-Item 'c:\temp\ErrorHandeling1.txt','c:\temp\ErrorHandeling2.txt' -ErrorAction SilentlyContinue
Remove-Item 'c:\temp\ErrorHandeling1.txt','c:\temp\ErrorHandeling2.txt' -ErrorAction Continue
Remove-Item 'c:\temp\ErrorHandeling1.txt','c:\temp\ErrorHandeling2.txt' -ErrorAction Stop

Write-Host -Object 'Exercise script ended successfully!' -ForegroundColor Yellow -BackgroundColor Black
#endregion
```

3. Save the file with a name like "Exercise1.ps1".
4. Create a breakpoint on line 3.
5. Run the script one line at a time.
6. Observe the behavior of the script and try to understand the difference between Terminating and Non-Terminating errors.

---

## Exercise 2: ErrorRecord Object and the $Error variable

1. Open the PowerShell ISE or any PowerShell editor of your choice.
2. Copy and paste the following code into the editor:

```powershell
#region ErrorRecord Object and the $Error variable

remove-item c:\nonexist.yahoo

# All errors are atored in $Error
$Error

# $Error variable is an array, use index to look inside
$Error[0]
$Error[0] | Select-Object *

# When the top level information isn't clear, go deeper
$Error[0].Exception
$Error[0].Exception | Format-List -Force
$Error[0].Exception.Message

# Clear it as you are dealing with the errors
$Error.Remove($Error[0]) # Removes only the last error
$Error.Clear() # Removes all the errors

#endregion
```
3. Save the file with a name like "Exercise2.ps1".
4. Create a breakpoint on line 3.
5. Run the script one line at a time.
6. Observe the behavior of the script and try to understand the ErrorRecord Object and the $Error variable.

---

## Exercise 3: Non-Terminating Errors and $ErrorActionPreference
 
 1. Open the PowerShell ISE or any PowerShell editor of your choice.
 2. Copy and paste the following code into the editor:
 
 ```powershell
 #region Non-Terminating Errors

remove-item c:\nonexist.yahoo
$?
$Error[0]
# Log file or custom message and continue the runtime of the script


$ErrorActionPreference
remove-item c:\nonexist.yahoo
$ErrorActionPreference = 'Break'
remove-item c:\nonexist.yahoo
$ErrorActionPreference = 'SilentlyContinue'
remove-item c:\nonexist.yahoo

#return ErrorActionPreference to "Normal State"
$ErrorActionPreference = 'Continue'

# Using the ErrorAction parameter
remove-item c:\nonexist.yahoo -ErrorAction SilentlyContinue
remove-item c:\nonexist.yahoo -ErrorAction 0

Write-Error 'My Custom Error'
$Error[0] 
$Error[0] | Select-Object *
Write-Error -Message 'My Custom Error 2' -ErrorId 5 -Exception 'MyException' 
$Error[0] 
$Error[0] | Select-Object *

#endregion
```
3. Save the file with a name like "Exercise3.ps1".
4. Create a breakpoint on line 3.
5. Run the script one line at a time.
6. Notice that after running for the first time line 12 the script will stop.
7. Remark line 11 and run the script again.
8. Notice that now $ErrorActionPreference is set to 'Stop' and will not change untill we change it.
9. In the console pane write the following command : $ErrorActionPreference = 'Continue'
10. Run the script again.
11. Observe the behavior of the script and try to understand the concepts of Non-Terminating errors and working with -ErrorAction common parameter, $ErrorActionPreference, and $Error variable.

---
## Exercise 4: Putting It All Together

1. Open the PowerShell ISE or any PowerShell editor of your choice.
2. Write a script that performs the following tasks:
   - Attempts to create a file in the C:\temp directory with the name "ErrorHandling.txt"
   - If the file creation fails, log the error in a file named "ErrorLog.txt"
   - If the file creation fails with a Non-Terminating error, the script should continue execution.
   - If the file creation fails with a Terminating error, the script should stop execution.
3. Save the file with a name like "Exercise4.ps1" and run it.
4. Observe the behavior of the script and try to understand how all the concepts we have learned so far come together to create a robust error handling system.
---
## *Congratulations! You have completed the PowerShell Error Handling Terminating and Non-Terminating exercise lab.*






