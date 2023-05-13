# Module 7 - GIT & GITHUB
<div>
    <img src="https://github.com/gadla/Public-PowerShell-Advanced-Automation-Techniques/blob/master/Images/git.jpg" alt="git" width="24%" />
    <img src="https://github.com/gadla/Public-PowerShell-Advanced-Automation-Techniques/blob/master/Images/github.jpg" alt="github" width="20%" />
</div>


<br>
<br>

## Task 1: Install your local GIT

1. Connect and login to [http://aka.ms/lod](http://aka.ms/lod) with your identity.
2. Open LAB 1 and log on to the VM "WIN10 (WDT)".
3. Download the 64-bit standalone setup of GIT from [https://git-scm.com/downloads](https://git-scm.com/downloads).
4. Install GIT.

<br>
<br>

## Task 2: Configure your GIT

1. Open PowerShell as Administrator.
2. Configure your Git username and email by executing the following commands:
   ```powershell
   git config --global user.name "Your Name"
   git config --global user.email "Your.Email@example.com"

<br>
<br>

## Task 3: Create your first (local) GIT repo

1. Create a new folder for your repository by running the following command in PowerShell:
   ```powershell
   New-Item -Path 'C:\' -Name 'gitDemo' -ItemType Directory
   ```
2. Change to the new folder using the following command:
   ```powershell
   Set-Location 'C:\gitDemo'
   ```
3. Create a sample file with some content:
   ```powershell
   'First Content' | Out-File -LiteralPath .\File.txt
   ```
4. Initialize your local Git repository:
   ```powershell
   git init
   ```
5. Check the status of your Git repository:
   ```powershell
   git status
   ```
6. Add the files to your Git repository (staging):
   ```powershell
   git add .
   ```
7. Check the status of your Git repository again:
   ```powershell
   git status
   ```
   You should see the File.txt listed.

 8. Commit your files to your local repository:
    ```powershell
    git commit -m "My first commit message"
    ```
 9. Make changes to the File.txt in your local repository:
    ```powershell
    Add-Content -LiteralPath .\File.txt -Value 'Second Content'
    ```
 10. Repeat the process of staging and committing the changes (steps 6-7).

<br>
<br>

## Task 4: View commits and move between commits
1. View your commit history:
    ```powershell
    git log
    ```
2. Revert to your initial commit by executing the following command (replace `{your commit ID}` with the actual commit ID for the initial commit):
    ```powershell
    git checkout {your commit ID}
    ```
3. Verify the content of the File.txt to see the original content:
    ```powershell
    Get-Content -Path '.\File.txt'
    ```
4. Move back to the master commit:
    ```powershell
    git checkout master
    ```

<br>
<br>

## Task 5: Create a GITHUB account
1. Open a web browser and navigate to https://github.com/.
2. Click on "Sign Up" on the left-hand side.
3. Fill in your email address.
4. Create a (strong) password.
5. Select an available username.
6. Choose whether you would like to receive updates.
7. Verify your email.
8. Select the free plan.

<br>
<br>

## Task 6: Create a new repository and upload your content
1. Create a new repository on GitHub and name it "gitDemo".
2. Link your existing local repository to your newly created GitHub repository:
    ```powershell
    git remote add origin https://github.com/YOUR-USER-NAME/gitDemo.git
    git push --set-upstream origin master
    ```
3. Check the contents of your repo in your browser.
4. Make a local change to a file then stage and commit locally and push to your GITHUB repo.
    3.1 Change your file: 
    ```powershell
    Add-Content -LiteralPath .\File.txt -Value 'Third Content'
    git add .
    git commit -m "Third commit message"
    git push
    ```
5. Browse to your project page and see the change.
6. Make a change through GITHUB to any of the files.
7. Update your local git repository:
    ```powershell
    git pull
    ```
8. Check and verify that the changes made in step 6 are reflected in your local repository.