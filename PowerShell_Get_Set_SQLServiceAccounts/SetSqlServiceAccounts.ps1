[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SqlWmiManagement") | out-null

#Prod gMSA SQL partners\MSACAPPRDSQL01$

#ServerName
$SQLServer = New-Object ('Microsoft.SqlServer.Management.Smo.Wmi.ManagedComputer') "CY1MSSCAPINTL02.partners.extranet.microsoft.com"

$SQLServer.Services | select name, type, ServiceAccount, DisplayName, Properties, StartMode, StartupParameters | where {$_.ServiceAccount -like "partners\msscpsql"} | Format-Table

#Query services which are running with current account
$ChangeService=$SQLServer.Services | where {$_.ServiceAccount -eq "partners\msscpsql"}
 
#$ChangeService=$SQLServer.Services | where {$_.name -eq "MSSQLSERVER"} #Make sure this is what you want changed!
$ChangeService | select name, type, ServiceAccount, DisplayName, Properties, StartMode, StartupParameters | Format-Table

$UName="partners\MSACAPPRDSQL01$"
$PWord=""

#Enable below to SET -make the change
#$ChangeService.SetServiceAccount($UName, $PWord)

#$ChangeService | select name, type, ServiceAccount, DisplayName, Properties, StartMode, StartupParameters | Format-Table


 