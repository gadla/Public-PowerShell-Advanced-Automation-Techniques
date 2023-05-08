# Lab Exercise: Handling Errors with Try-Catch-Finally

## Objective
The objective of this lab exercise is to familiarize students with the `try`, `catch`, and `finally` statements in PowerShell and to teach them how to handle errors in a controlled and predictable way.

The objective of this lab exercise is to familiarize students with the try, catch, and finally statements in PowerShell and to teach them how to handle errors in a controlled and predictable way.

After completing this lab, students should be able to:

- Understand the purpose and benefits of error handling in PowerShell
- Understand the syntax and usage of try, catch, and finally blocks
- Implement error handling logic in their PowerShell scripts to catch and handle specific types of errors and exceptions
- Log error messages, display user-friendly error messages, and perform cleanup actions in their scripts
- Use error handling to write more reliable and robust scripts that can gracefully handle unexpected errors and exceptions.

By mastering these skills, students will be better equipped to write PowerShell scripts that can interact with external systems and resources in a reliable and predictable way, and troubleshoot and debug complex scripts more effectively. This will help them become more effective and efficient PowerShell users, and enable them to contribute more value to their organizations.

## Exercise
In this exercise, you will practice handling errors in PowerShell using the `try`, `catch`, and `finally` statements.

1. Open the PowerShell ISE or any PowerShell editor of your choice.

2. Create a new script file and save it as `try-catch-finally.ps1`.

3. In the script, define a function called `Convert-StringToInt` that takes a single parameter, `$value`.

4. In the function body, use a `try` statement to convert the input string to an integer using the `[int]::Parse` method and assign the result to a variable called `$result`.

5. Use multiple `catch` statements to catch any errors that may occur during the conversion operation, including a `System.FormatException` for invalid input and a `System.OverflowException` for values that are too large or small to fit into an `int` data type.

6. In each `catch` block, use the `Write-Error` cmdlet to output a custom error message that includes the exception message.

7. Use a `finally` block to output a message that indicates the end of the operation, regardless of whether an error occurred or not.

8. Outside of the function, call the `Convert-StringToInt` function with various input values, including some that would result in conversion errors.

9. Save the script and execute it in PowerShell.

10. Observe the output of the script and verify that it handles errors correctly and always outputs the final message.

11. (Optional) Modify the script to include additional error-handling logic, such as logging the error messages to a file or retrying the operation in case of transient errors.

Here's an example of what the `Convert-StringToInt` function and the error-handling blocks might look like in the `try-catch-finally.ps1` script:

```powershell
function Convert-StringToInt {
    param (
        [string]$value
    )

    try {
        $result = [int]::Parse($value)
        Write-Output "The result is: $result"
    }
    catch [System.FormatException] {
        Write-Error "Invalid input value: '$value'. $($_.Exception.Message)"
    }
    catch [System.OverflowException] {
        Write-Error "Value out of range: '$value'. $($_.Exception.Message)"
    }
    finally {
        Write-Output "End of operation."
    }
}

Convert-StringToInt "42"
Convert-StringToInt "foo"
Convert-StringToInt "999999999999999999"
Convert-StringToInt "-999999999999999999"
```