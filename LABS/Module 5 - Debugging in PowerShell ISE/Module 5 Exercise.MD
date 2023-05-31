# PSLab Exercise: PowerShell Debugging with Breakpoints

## Excercise instructions
```
Debugging PowerShell scripts is an important skill for any PowerShell developer or administrator. 
In this lab exercise, you will learn how to use the PowerShell ISE debugger to set line breakpoints, step through code, and examine variables.
```


## Objectives

```
By the end of this lab, you will be able to:

  - Set line breakpoints in a PowerShell script.
  - Use the debugger to step through code.
  - Examine variables during script execution.
```


## Prerequisites
```
Download the DebuggingLab.ps1 script from the github page.
Copy the file to the C:\PSLabs drive on your computer (create the folder if it doesn't exist).
```

#### Creating a breakpoint

```
1. Open PowerShell ISE as an administrator.
3. Open the script file c:\PSLabs\DebuggingLab.ps1 in PowerShell ISE.
4. Create a breakpoint at line 14 using the F9 key or by Debug and then Toggle BreakPoint from the menu. The line should be bold with red color.
5. Run the script by pressing F5 or clicking on the green Run Script button on the toolbar.
6. The script should stop at the breakpoint at line 14.
7. You should see the following message in the console pane: Hit Line breakpoint on 'C:\PSLabs\DebuggingLab.ps1:14'
8. Stop the script by pressing Shift+F5 or clicking on the Debug and then Stop Debugger from the menu.
9. Create another breakpoint at line 16 using the F9 key or by Debug and then Toggle BreakPoint from the menu. The line should be bold with red color.
10. Run the script again by pressing F5 or from the Debug Run/Continue menu.
11. The script should stop at the breakpoint at line 14.
12. Continue to the next breakpoint by pressing F5 or from the Debug Run/Continue menu. The script should stop at the breakpoint at line 16.
13. Run the script untill it ends.
14. Create another breakpoint at line 7. The line should be bold with red color.
15. Run the script again by pressing F5 or clicking on the green Run Script button on the toolbar. The script should stop at the breakpoint at line 14.
16. Press F5 or Debug Run/Continue to the next breakpoint. The script should stop at line 16.
17. Press F5 or Debug Run/Continue to the next breakpoint. The script should stop at line 7.
18. Run the script untill it ends.
19. Clear all breakpoints by Debug and then Remove All Breakpoints from the menu.
20. Run the script again by pressing F5 or clicking on the green Run Script button on the toolbar. The script should run without stopping.
```
#### Examine variables

```
1. Verify that there are no breakpoints set in the script.
2. Create a breakpoint at line 16. The line should be bold with red color.
3. Run the script by pressing F5 or clicking on the green Run Script button on the toolbar. The script should run and stop at line 16.
4. Press the F11 key untill you get to line 7.
5. At the console pane (the blue pane at the bottom of the PowerShell ISE window), type $Repetition and press Enter. The value of the $Repetition variable should be displayed.
6. Continue to run the script with F11, check priordically the value of the $Repetition variable.
7. Clear all breakpoints by Debug and then Remove All Breakpoints from the menu.

```

#### Step into step over and step out

```
1. Verify that there are no breakpoints set in the script.
2. Create a breakpoint at line 16. The line should be bold with red color.
3. Run the script by pressing F5 or clicking on the green Run Script button on the toolbar. The script should run and stop at line 16.
4. Press the F10 key, the script should run the function and then stop in line 17 the line will be highlighted in orange. 

This is because the F10 key is the Step Over key. It will execute the current line and then stop at the next line. Since line 16 is a single line command, it will execute the command and then complete because there are no more lines to execute.

5. Run the script again. The script should stop at line 16.
6. Press the F11 key, the script should stop at line 7 and the line should be highlighted in yellow.
7. Press the F11 key again, the script should stop at line 8.
8. Press the F11 key again, the script should stop at line 9.
9. Press the F11 key again, the script should stop at line 10.
10. Press the F5 key to continue the script. The script should complete.

This is because the F11 key is the Step Into key. It will execute the current line and then stop at the next line. Since line 7 is a function call, it will execute the function and then stop at the first line of the function.

11. Run the script again. The script should stop at line 16.
12. Press the F11 key, the script should stop at line 7 and the line should be highlighted in yellow.
13. Press the F10 key, the script should stop at line 8.
14. Press the F10 key, the script should stop at line 9.
15. Press the F10 key, the script should stop at line 10.
16. Press the Shift + F11 keys or by Debug Step Out to continue the script. The script should complete and you should be back at line 17 that should be highlighted in orange.

This is because the Shift + F11 key is the Step Out key. It will execute the current line and then stop at the next line. Since line 16 is a function call, it will execute the function and then stop at the first line of the function. The Shift + F11 key will then execute the rest of the function and stop at the line after the function call.

```
## Variable BreakPoint
```
1. Verify that there are no breakpoints set in the script.
2. Verify that you are in the C:\PSLabs folder.
3. Run the command: 
    Set-PSBreakpoint -Variable Repetition -Action {
    # Write the value of the variable to a file
    $value = Get-Variable -Name Repetition -ValueOnly
    $value = "Current value of Repetition is: $value"
    $value | Out-File -FilePath C:\pslabs\VariableBreakPoint.txt -Append
    }
4. Run the script by pressing F5 or clicking on the green Run Script button on the toolbar. The script should run and complete.
5. Open the file C:\pslabs\VariableBreakPoint.txt and verify that the value of the Repetition variable was written to the file.
6. Clear all breakpoints by running the command: Get-PSBreakpoint | Remove-PSBreakpoint in the console pane.
```

## Command BreakPoint
```
1. Verify that there are no breakpoints set in the PowerShell console by running the command: Get-PSBreakpoint.
2. Verify that you are in the C:\PSLabs folder.
3. Run the command: 
   Set-PSBreakpoint -Command "Demo-Function" -Action {
     # Write the output of the command to a file
     $output = "$(get-date -Format "dd-MM-yyyy:ss") - Demo-Function was called"
     $output | Out-File -FilePath C:\PSLabs\CommandBreakPoint.txt -Append
    }
4. Run the command Demo-Function.
5. Check the file C:\PSLabs\CommandBreakPoint.txt and verify that the output of the Demo-Function was written to the file.
```