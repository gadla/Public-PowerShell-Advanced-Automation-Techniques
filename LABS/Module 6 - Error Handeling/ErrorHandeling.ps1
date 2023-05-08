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
