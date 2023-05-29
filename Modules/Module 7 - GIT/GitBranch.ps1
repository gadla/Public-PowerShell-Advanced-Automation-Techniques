# Step 1: Create a new directory for your project and initialize it as a Git repository
New-Item -Path 'C:\temp' -Name 'MyProject' -ItemType 'directory' -Force
set-location 'C:\temp\MyProject'
git init

# Step 2: Create an initial commit. This is necessary to have a base for your feature branches.
'# My Project' | Out-File -FilePath 'C:\temp\MyProject\README.md' -Encoding 'UTF8'
git add README.md
git commit -m "Initial commit"

# Step 3: Create two branches named Feature_A and Feature_B
git branch Feature_A
git branch Feature_B

# Step 4: Switch to Feature_A branch
git checkout Feature_A

# Step 5: Make a change in the Feature_A branch. For this demo, let's add a line to the README file.
'This is a line from Feature_A.' | Out-File -FilePath 'C:\temp\MyProject\README.md' -Append -Encoding 'UTF8'

# Step 6: Commit the change
git add README.md
git commit -m "Add a line in Feature_A branch"

# Step 7: Switch back to the master branch
git checkout master
Get-Content -Path C:\temp\MyProject\README.md
# Step 8: Merge the Feature_A branch into the master branch
git merge Feature_A
Get-Content -Path C:\temp\MyProject\README.md
