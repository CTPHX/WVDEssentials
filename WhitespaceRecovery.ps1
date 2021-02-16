# Ensure that the runbook does not inherit an AzContext
Disable-AzContextAutosave –Scope Process

# Connect to Azure with Run As account
$ServicePrincipalConnection = Get-AutomationConnection -Name 'AzureRunAsConnection'

Connect-AzAccount `
    -ServicePrincipal `
    -Tenant $ServicePrincipalConnection.TenantId `
    -ApplicationId $ServicePrincipalConnection.ApplicationId `
    -CertificateThumbprint $ServicePrincipalConnection.CertificateThumbprint

$AzureContext = Set-AzContext -SubscriptionId $ServicePrincipalConnection.SubscriptionID

Start-AzAutomationRunbook `
    –AutomationAccountName 'NAME-HERE' `
    –Name '-Path \\server\share -Recurse -LogFilePath C:\MyLogFile.csv' `
    -ResourceGroupName 'RG HERE' `
    -AzContext $AzureContext `
    –Parameters -Path \\SERVER\SHARE -Recurse
