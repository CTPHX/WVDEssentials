$conn = Get-AutomationConnection -Name AzureRunAsConnection
Add-AzAccount -ServicePrincipal -Tenant $conn.TenantID -ApplicationID $conn.ApplicationID -CertificateThumbprint $conn.CertificateThumbprint

Import-Module Az.Compute

$VMs = Get-AzVM | where {$_.Tags.Values -like '*wring2*'}

$tags = @{"wvdscale"="noscale"}

Update-AzTag -ResourceId $VMs.id -Tag $tags -Operation Delete

$VMs | stop-AzVM -Force

Write-Output $VMs.Name 
