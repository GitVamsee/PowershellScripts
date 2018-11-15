#Get SQL service accounts, query by service account or service name
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SqlWmiManagement") | out-null

#Input ServerName
$SQLServer = New-Object ('Microsoft.SqlServer.Management.Smo.Wmi.ManagedComputer') "CY1CAPSQLREP02.partners.extranet.microsoft.com"
$Logfile = $SQLServer.Name

#Query with service account
$SQLServer.Services | select name, type, ServiceAccount, DisplayName, Properties, StartMode, StartupParameters | where {$_.ServiceAccount -eq "partners\msscpsql"} | Format-Table | Tee-Object -FilePath .\$Logfile.txt
#$SQLServer.Services | select name, type, ServiceAccount, DisplayName, Properties, StartMode, StartupParameters | where {$_.name -eq "MSSQLSERVER"} | Format-Table
#$SQLServer.Services | select name, type, ServiceAccount, DisplayName, Properties, StartMode, StartupParameters| where {$_.ServiceAccount -eq "partners\msscpsql"} | Format-List
