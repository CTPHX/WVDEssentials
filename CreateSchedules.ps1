#Please import AZ.Accounts & Az.Automation into your AZ Automation Account

#Variables
$ResourceGroup = 'XXXXXX'
$AutomationAccount = 'XXXXXX'

# Connect to Azure with Run As account
$ServicePrincipalConnection = Get-AutomationConnection -Name 'AzureRunAsConnection'

Connect-AzAccount `
    -ServicePrincipal `
    -Tenant $ServicePrincipalConnection.TenantId `
    -ApplicationId $ServicePrincipalConnection.ApplicationId `
    -CertificateThumbprint $ServicePrincipalConnection.CertificateThumbprint

$AzureContext = Set-AzContext -SubscriptionId $ServicePrincipalConnection.SubscriptionID


#Create Schedule for Whitespace Recovery
$StartTime = (Get-Date "22:00:00").AddDays(1)
New-AzAutomationSchedule -AutomationAccountName $AutomationAccount -Name "Whitespace" -StartTime $StartTime -WeekInterval 1 -DaysOfWeek 'Sunday' -ResourceGroupName $ResourceGroup

#Create Schedule for WVD Ring 1 Startup
$StartTime = (Get-Date "01:00:00").AddDays(1)
[System.DayOfWeek[]]$WeekendDay = @([System.DayOfWeek]::Sunday)
New-AzAutomationSchedule -AutomationAccountName $AutomationAccount -Name "Ring1Startup" -StartTime $StartTime -DayOfWeekOccurrence 'Second' -DayOfWeek 'Sunday' -MonthInterval '1' -ResourceGroupName $ResourceGroup

#Create Schedule for WVD Ring 1 Shutdown
$StartTime = (Get-Date "07:00:00").AddDays(1)
[System.DayOfWeek[]]$WeekendDay = @([System.DayOfWeek]::Sunday)
New-AzAutomationSchedule -AutomationAccountName $AutomationAccount -Name "Ring1Shutdown" -StartTime $StartTime -DayOfWeekOccurrence 'Second' -DayOfWeek 'Sunday' -MonthInterval '1' -ResourceGroupName $ResourceGroup

#Create Schedule for WVD Ring 1 Startup
$StartTime = (Get-Date "01:00:00").AddDays(1)
[System.DayOfWeek[]]$WeekendDay = @([System.DayOfWeek]::Sunday)
New-AzAutomationSchedule -AutomationAccountName $AutomationAccount -Name "Ring2Startup" -StartTime $StartTime -DayOfWeekOccurrence 'Fourth' -DayOfWeek 'Sunday' -MonthInterval '1' -ResourceGroupName $ResourceGroup

#Create Schedule for WVD Ring 1 Shutdown
$StartTime = (Get-Date "07:00:00").AddDays(1)
[System.DayOfWeek[]]$WeekendDay = @([System.DayOfWeek]::Sunday)
New-AzAutomationSchedule -AutomationAccountName $AutomationAccount -Name "Ring2Shutdown" -StartTime $StartTime -DayOfWeekOccurrence 'Fourth' -DayOfWeek 'Sunday' -MonthInterval '1' -ResourceGroupName $ResourceGroup
