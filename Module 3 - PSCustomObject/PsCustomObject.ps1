##########################################################################################
####               General description usage and creation of PsCustomObject       ########
##########################################################################################

# Creating PsCustomObject Old and not preferred Method 
$props = @{
    Name = 'Gadi'
    age = 48
    Planet = 'Earth'
    birthdate = Get-Date -Date "1974-11-23"
}
$person = New-Object -TypeName pscustomobject -Property $props

# Display the new object
$person

# Creating PsCustomObject New and Preferred Method

$person = [pscustomobject]@{
    Name= 'Gadi'
    age = 48
    Title= 'CE Platform Active Directory'
    Planet= 'Earth'
    birthdate = Get-Date -Date "1974-11-23"
} 


# Display the new object
$person
$person.Name


# Listing all properties
$person.psobject.Properties.Name
$person | get-member -MemberType NoteProperty | Select-Object -ExpandProperty name
Get-Member -InputObject $person -MemberType NoteProperty | Select-Object -ExpandProperty name



##########################################################################################
####                    Changing our PsCustomObject properties                    ########
##########################################################################################


# Dynamically change properties
$person.Planet = 'Mars'
$person

#Dynamically Add new Property to an existing object
$person | Add-Member -MemberType NoteProperty -Name 'Favourite_Food' -Value 'Steak'
$person.Favourite_Food
$person | Add-Member -MemberType NoteProperty -Name 'Favourite_Drink' -Value 'Club Soda'
$person

# Removing property from an existing object
$person.PSObject.Properties.Remove('favourite_Drink')
$person
Get-Member -InputObject $person -MemberType Properties | Select-Object -ExpandProperty Name | Sort-Object

# Explain why we cant find the PSObject under our $person object
# If you run the command: 
$person | get-member 

# There is no PSObject property, hmmm you should find it by using :
$person | get-member -force






##########################################################################################
####                    Adding Methods to our PSCustomObject                      ########
##########################################################################################

$method = {
    "Hi, my name is $($this.name) and I like to write PowerShell Code!"
}

$params = @{
    MemberType = 'ScriptMethod'
    Name       = 'SayHi'
    Value      = $method
}

$person | Add-Member @params
$person.SayHi()


# Converting PsCustomObject to HashTable
$params = @{
    MemberType = 'ScriptMethod'
    Name       = 'OutHashTable'
    Value      = {
        $hash = @{}
        $this.psobject.properties.name.foreach({
            $hash[$_] = $this.$_
        })
        return $hash
    }
}
$person | Add-Member @params
$person.OutHashTable()




##########################################################################################
####                    Understanding types and why do we care                    ########
##########################################################################################

#region Types
#What are types? - explanation
$person | Get-Member # now it is PsCustomObject

$person.psobject.TypeNames # This looks familiar
$person.psobject.TypeNames.insert(0, "Gadla.Person") #Changing the PsCustomObject to another type
$person | Get-Member

#Creating a function that recieves only Gadla.Person type of objects
function Say-Hello {
    param (
        # We only accept parameter of type Gadla.Person
        [PSTypeName('Gadla.Person')]
        [Parameter(ValueFromPipeline)]
        $SpecificPerson
    )

    Write-Output $SpecificPerson.SayHi()
}
Say-Hello -SpecificPerson $person

#endregion


##########################################################################################
####                                 Exporting PsCustomObject                     ########
##########################################################################################
#region Export and Import PSObject

# Saving to a file (CSV)
# This will demonstrate you why JSON is a better format
$person | Export-Csv -Path 'C:\TEMP\psobject_to_csv.csv' -NoTypeInformation
$importedPerson = Import-Csv -Path 'C:\TEMP\psobject_to_csv.csv'
$importedPerson
$importedPerson.birthdate.GetType()


# Saving to a file (JSON):
# We could save to a CSV, but CSV doesn't support nested properties, thus why JSON is preferable
$Path = 'C:\TEMP\psobject_to_json.json'
$person | ConvertTo-Json -Depth 5 | Set-Content -Path $Path
$importedPerson = Get-Content -Path $Path
$importedPerson
$ImportedPersonJson = $importedPerson | ConvertFrom-Json
$ImportedPersonJson
$ImportedPersonJson.birthdate.GetType()

# Saving to a file (XML)
$xmlpath = 'C:\temp\pso.xml'
$person | Export-Clixml -Path $xmlpath
$xmlPerson = Import-Clixml -Path $xmlpath
$xmlPerson
$xmlPerson.birthdate.GetType()

#endregion