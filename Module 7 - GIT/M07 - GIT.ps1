<#
User for Demo is gadlaPowershell@outlook.com
password is A!

Steps:
1. Download and install VS Code from https://code.visualstudio.com/
2. Install the PowerShell extension
3. Download and install GIT from https://git-scm.com/download/win
4. Initial configuration of GIT
4.1 git config --global user.name "Gadi Lev-Ari"
4.2 git config --global user.email "GadlaPowershell@Outlook.com"
5. Demo Local repository with GIT
5. Create a GITHUB account with the above user
6. Create a repo
7. Clone Repo

#>


<#   
GIT Config
----------
git config --global user.name "Gadi Lev-Ari"
git config --global user.email "GadlaPowershell@Outlook.com"
#>



##########################
#local repository with GIT
##########################

# Initialize our new repository
New-Item -Path 'C:\' -Name 'GitDemo' -ItemType Directory
set-location -Path 'C:\GitDemo'
git init

# Adding files
get-childitem -Hidden
New-Item -Name file.ps1
Add-Content -Value 'First version' -Path .\file.ps1 
git status
git add .

#first commit
git commit -m "First file commit"
git log

#Change our file and second commit
Add-Content -Value 'Second version' -Path .\file.ps1
git add .\file.ps1
git commit -m "Changing file.ps1"
git log

# Moving in our timeline
git log
git checkout $CommitID
Get-Content .\file.ps1
#return to Master
git checkout master

#deleting files
Remove-Item .\file.ps1
git status
git restore .\file.ps1


# Branching
git branch 'Feature_One'
git branch
git checkout 'Feature_One'
'Branch Content' | Out-File -FilePath .\file.ps1
'Second file' | Out-File -FilePath .\file2.txt
git add .
git commit -m "Branch first commit"



#################################################################################################################################
#################################################################################################################################
GITHUB
#################################################################################################################################
#################################################################################################################################

