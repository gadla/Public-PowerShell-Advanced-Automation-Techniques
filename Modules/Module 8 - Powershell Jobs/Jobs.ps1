Start-Job -ScriptBlock { Get-ChildItem -Path 'C:\windows\System32\WindowsPowerShell' -Recurse | Sort-Object Length }

Start-Job -ScriptBlock { Get-ChildItem -Path 'C:\windows\System32\WindowsPowerShell' -Recurse | Sort-Object Length } -name 'SuperLongDirectoryDir'

stop-job -id $JobIdNumber

#you should save the informaion into a variable
Receive-Job -id $JobIdNumber 
Recieve-Job -id $JobIdNumber -keep
$Results = Receive-Job -id $JobIdNumber
Write-Output $Results

get-job | Remove-Job
#explain the memory management and the process of garbage collector

invoke-command -ScriptBlock {Get-WinEvent -LogName security -MaxEvents 5} -ComputerName 'Contoso-DC1' -AsJob -JobName 'EventLogGrabberDC1'


#WMI Jobs
Get-WmiObject -Class win32_bios -ComputerName Contoso-AAD,Contoso-DC1 -AsJob -JobName 'GetBios-Contoso-AAD'

#Show ChildJobs
Get-Job -id $YourWmiJobID | Select-Object -ExpandProperty ChildJobs
Get-Job -Id $JobIdNumber -IncludeChildJob

Get-Job -Id $JobIdNumber -ChildJobState Completed



#Scheduled JOBS vs Scheduled TASKS 
# You should run this on Windows Powershell !!!!!!!!!!!
get-command -Module ScheduledTasks
get-command -Module PSScheduledJob

<#
The Scheduled JOBS has the following elements:
1. New-JobTrigger - what is the trigger of the job? this can be time based daily/weekle ect
2. New-ScheduledJobOptions - what are the options for the job
3. Register-ScheduledJob - Register the Job into Task Scheduler

From this point you can:
* Get-ScheduledJob
* Get-ScheduledJobOptions
* Disable-ScheduledJob / Enbale-ScheduledJob
* Set-ScheduledJob - you can change existing Job
* Set-ScheduledJobOptions
* Unregister-ScheduledJob
#>

get-help New-JobTrigger
$trigger = New-JobTrigger -AtLogOn  
$options = New-ScheduledJobOption -RequireNetwork
get-help Register-ScheduledJob
Register-ScheduledJob -Name 'MyScheduledJob' -ScriptBlock {get-childitem -Path 'C:\windows\System32\WindowsPowerShell\' -Recurse } -MaxResultCount 3 -Trigger $trigger -ScheduledJobOption $options
#The job is now under Task Scheduler in the following path: \Microsoft\Windows\Powershell\ScheduledJobs
# After you logoff and logonn
get-ScheduledJob
Get-Job # Now we can see the data from the ScheduledJob
Receive-Job -id $ScheduledJobID 
#Note that the PowerShell Shell reads the information only once but if you start new PowerShell Host it will have all of the information

get-scheduledJob -id 3 | Select-Object -Property *
<#
InvocationInfo         : Microsoft.PowerShell.ScheduledJob.ScheduledJobInvocationInfo
Definition             : System.Management.Automation.JobDefinition
Options                : Microsoft.PowerShell.ScheduledJob.ScheduledJobOptions
Credential             :
JobTriggers            : {1}
Id                     : 3
GlobalId               : 003c835a-7f96-4c84-bacf-3b6bb12bf909
Name                   : MyScheduledJob
Command                : get-childitem -Path 'C:\windows\System32\WindowsPowerShell\' -Recurse
ExecutionHistoryLength : 3
Enabled                : True
PSExecutionPath        : powershell.exe
PSExecutionArgs        : -NoLogo -NonInteractive -WindowStyle Hidden -Command "Import-Module PSScheduledJob; $jobDef =
                         [Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition]::LoadFromStore('MyScheduledJob',
                         'C:\Users\Admin\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs'); $jobDef.Run()"
#>
