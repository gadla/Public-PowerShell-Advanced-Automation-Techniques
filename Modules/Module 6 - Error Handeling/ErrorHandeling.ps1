#region Terminating vs. Non-Terminating errors

New-Item -Path c:\temp -Name ErrorHandeling1.txt
New-Item -Path c:\temp -Name ErrorHandeling2.txt

New-Item -Path c:\temp -Name ErrorHandeling1.txt
remove-item 'c:\temp\ErrorHandeling1.txt'
Remove-Item 'c:\temp\ErrorHandeling1.txt','c:\temp\ErrorHandeling2.txt'
Remove-Item 'c:\temp\ErrorHandeling1.txt','c:\temp\ErrorHandeling2.txt' -ErrorAction Stop

#endregion







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


#region Inroduction to Terminating Errors

#Terminating Error Example
Get-WmiObject -ComputerName NoComputer -Class win32_bios -ErrorAction stop
$Error[0]

function Get-Trap {
    trap {
        Write-Output 'Trap caught'
        #continue
        break
    }
    Get-WmiObject -ComputerName NoComputer -Class win32_bios -ErrorAction stop
    Write-Output 'exiting Get-Trap function'
}
Get-Trap
#see the difference in the trap section between continue and break

#throw example
function Get-ThrowExample {
    param(
        [string]$ServiceName = $(throw 'You must specify a Computername parameter value')
    )
    Get-Service -Name $ServiceName
}
Get-ThrowExample 
Get-ThrowExample -ServiceName 'Spooler'


#endregion


#region Catching Terminating Errors Try {} Catch {} Finally {}

#example: Try/Catch/Finally

function Get-TryCatchFinally {
    try {
        Get-Content -Path c:\notexist.txt -ErrorAction Stop
    }
    catch {
        Write-Output "Exception found: $($_.Exception.Message)"
    }
    finally {
        Write-Output 'Finally Block Code'
    }
}
Get-TryCatchFinally

#Example Scopes and Try/Catch/Finally

function Get-ScopesTryCatchFinally {
    try{NotExistCommand}
    catch {
        Write-Output 'Error trapped inside the function'
        throw
    }
}
Write-Output "`nStarting Script!`n"
Try { Get-ScopesTryCatchFinally }
Catch { "Internal Function Error re-thrown: $($_.ScriptStackTrace)" }
Write-Output "`nScript Completed!"

function Get-TryCatchFinallyCustomError {
    param ([string]$Filename)
    try{
        if(-not(Test-Path $Filename)){
        throw 'File not found exception'
        }
        $content = Get-Content -Path $Filename
    } 
    catch {
        Write-Output 'General Error'
        $_.Exception.Message
    }

    Write-Output $content
}
Get-TryCatchFinallyCustomError -Filename C:\temp\computers.txt
Get-TryCatchFinallyCustomError -Filename .\NotExist.txt

#This Example uses multiple catch blocks

function Get-MultipleTryCatch {
    try {
        write-host -Object 'Try block starts here' -ForegroundColor green -BackgroundColor black     
        Get-Content c:\f\NonExistingFile.txt -ErrorAction stop
    }
    #rename file
    catch [System.Management.Automation.ItemNotFoundException] {
        Write-Host -Object 'Item Not Found exception' -ForegroundColor DarkMagenta -BackgroundColor black
    }
    #remove access to file
    catch [System.UnauthorizedAccessException] {
        write-host -Object 'Access denied exception!' -ForegroundColor red -BackgroundColor black     
    }
    catch {
        write-host -Object 'General exception' -ForegroundColor red -BackgroundColor black
    }
    finally {
        write-host -Object 'This is finally block' -ForegroundColor yellow -BackgroundColor black
    }
}

#Throw exception
function Get-TryCatchFinallyCustomError2 {
    param ([string]$Filename)
    try{
        if(-not(Test-Path $Filename)){
            throw 'File not found exception'
        }
        if($Filename -ne 'MyFileName.txt') {
            throw [MyException] 'MyException'
        }
        $content = Get-Content -Path $Filename
        Write-Output $content
    } 
    catch [MyException] {
        Write-Output 'My Exception Error'
        $_.Exception.Message
    }
    catch {
        Write-Output 'General Error'
        $_.Exception.Message
    }

}
Get-TryCatchFinallyCustomError2 -Filename C:\temp\computers.txt
Get-TryCatchFinallyCustomError2 -Filename .\NotExist.txt


#endregion


