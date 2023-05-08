# PSLab: PSCustomObject

### Function structure:

```PowerShell
function function Convert-StringToInt {
    param(...
}
```


### Sample outputs: 

```PowerShell
Convert-StringToInt "42"
Output:
The result is: 42
End of operation



Convert-StringToInt "foo"
Output:
Convert-StringToInt : Invalid input value: 'foo'. Input string was not in a correct format.
At line:1 char:1
+ Convert-StringToInt "foo"
+ ~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [Write-Error], WriteErrorException
    + FullyQualifiedErrorId : Microsoft.PowerShell.Commands.WriteErrorException,Convert-StringToInt
 
End of operation.


Convert-StringToInt "999999999999999999"
Output:
Convert-StringToInt : Value out of range: '999999999999999999'. Value was either too large or too small for an Int32.
At line:1 char:1
+ Convert-StringToInt "999999999999999999"
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [Write-Error], WriteErrorException
    + FullyQualifiedErrorId : Microsoft.PowerShell.Commands.WriteErrorException,Convert-StringToInt
 
End of operation.


Convert-StringToInt "-999999999999999999"
Output:
Convert-StringToInt : Value out of range: '-999999999999999999'. Value was either too large or too small for an Int32.
At line:1 char:1
+ Convert-StringToInt "-999999999999999999"
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [Write-Error], WriteErrorException
    + FullyQualifiedErrorId : Microsoft.PowerShell.Commands.WriteErrorException,Convert-StringToInt
```