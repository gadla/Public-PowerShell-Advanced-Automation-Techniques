# Module 7 - GIT & GITHUB

### Task1 : Install your local GIT
```
1. Connect and login to http://aka.ms/lod with your identity
2. Open LAB 1 and log on to the vm "WIN10 (WDT)"
3. Download GIT from https://git-scm.com/downloads (Download the 64-bit Standalone setup)
4. Install GIT
```


### Task 2: Configure your GIT
```
1. Open PowerShell as Administrator
2. type: git config --global user.name "My Name"
3. type: git config --global user.email "My.Email@example.com"

Keep your PowerShell host open for the next task
```


### Task 3: Create your first (local) GIT repo
```
1. Create a new folder: New-Item -Path 'C:\' -Name 'MyNewFolder' -ItemType Directory
2. Go to your new folder: Set-Location 'C:\MyNewFolder'
3. Create a sample file: 'First Content' | Out-File -LiteralPath .\File.txt
4. Initialize your local git repository: git init
5. Add files to your git repository (STAGING): git add .
5. Commit your files to your local repository: git commit -m "My first commit message"
6. Make changes to a file in your local repository: Add-Content -LiteralPath .\File.txt -Value 'Second Content'
7. Repeate the process of staging and commit

Keep your PowerShell host open for the next task
```


### Task 4: View commits and move between commits
```
1. View your commit history: git log
2. Revert to your initial commit: git checkout {your commit ID}
3. Verify your original content: Get-Content -Path .\File.txt
4. Move back to master commit: git checkout master
```

### Task 5: Create a GITHUB account
```
1. Open a web browser and type the address https://github.com/
2. Click on Sing Up (On the left)
3. Fill in your email address 
4. Create a (strong) password
5. Select (an available) username
6. Select if you would like to receive updates
7. Verify your email
8. Select the free plan
```


### Task 6: Create a new repository and upload your content 
```
1. Create a new repository in GITHUB 
2. Link your existing repo to your newly created GITHUB repo    
    2.1 git remote add origin https://github.com/YOUR-USER-NAME/gitDemo.git
    2.2 git push --set-upstream origin master
3. Make a local change to a file then stage and commit locally and push to your GITHUB repo
    3.1 Change your file: Add-Content -LiteralPath .\File.txt -Value 'Third Content'
    3.2 git add .
    3.3 git commit -m "Third commit message"
    3.4 git push
4. Browse to your project page and see the change.
5. Make a change through GITHUB to any of the files.
6. Update your local git repository
    6.1 git pull
```
