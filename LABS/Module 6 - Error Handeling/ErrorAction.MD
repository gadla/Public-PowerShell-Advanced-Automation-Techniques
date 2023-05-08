# Lab Exercise: Understanding -ErrorAction and $ErrorActionPreference

## Objective
The objective of this lab exercise is to familiarize students with the `-ErrorAction` parameter and `$ErrorActionPreference` variable in PowerShell and to teach them how to control error handling behavior.

By the end of this lab, students will be able to use the `-ErrorAction` parameter and `$ErrorActionPreference` variable to control error handling behavior in PowerShell. They will understand the purpose and benefits of these options and how to use them to handle errors in a way that meets their specific needs.

## Exercise
In this exercise, you will practice using the `-ErrorAction` parameter and `$ErrorActionPreference` variable in PowerShell to control error handling behavior.

1. Open the PowerShell ISE or any PowerShell editor of your choice.

2. Create a new script file and save it as `error-action.ps1`.

3. In the script, define a function called `Test-ErrorAction` that contains a statement that will cause an error, such as trying to access an undefined variable or non-existent file.

4. Call the `Test-ErrorAction` function with different values of the `-ErrorAction` parameter, including `SilentlyContinue`, `Stop`, `Continue`, and `Inquire`.

5. Observe the output of the script and verify that it handles errors according to the value of the `-ErrorAction` parameter.

6. Set the `$ErrorActionPreference` variable to different values, including `SilentlyContinue`, `Stop`, `Continue`, and `Inquire`.

7. Call the `Test-ErrorAction` function again without specifying the `-ErrorAction` parameter.

8. Observe the output of the script and verify that it handles errors according to the value of the `$ErrorActionPreference` variable.

9. Save the script and execute it in PowerShell.

10. Modify the script to include additional error-handling logic, such as logging the error messages to a file or retrying the operation in case of transient errors.

Here's an example of what the `Test-ErrorAction` function might look like in the `error-action.ps1` script:

```powershell
function Test-ErrorAction {
    Write-Host "Testing error action behavior..."
    $undefinedVariable = $null
    $undefinedVariable.ToString()
}

Test-ErrorAction -ErrorAction SilentlyContinue
Test-ErrorAction -ErrorAction Stop
Test-ErrorAction -ErrorAction Continue
Test-ErrorAction -ErrorAction Inquire

$ErrorActionPreference = "SilentlyContinue"
Test-ErrorAction
$ErrorActionPreference = "Stop"
Test-ErrorAction
$ErrorActionPreference = "Continue"
Test-ErrorAction
$ErrorActionPreference = "Inquire"
Test-ErrorAction
```