[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SqlWmiManagement") | out-null

#Prod gMSA SQL partners\MSACAPPRDSQL01$

$ServerList = @("CO1CAPLIVESQL.partners.extranet.microsoft.com", "CY1MSSCAPLDBRDS.partners.extranet.microsoft.com", "CY1CAPSQLREP02.partners.extranet.microsoft.com","CY1CAPSQLREP01.partners.extranet.microsoft.com")

foreach ($Server in $ServerList) 
{

        #ServerName
        $SQLServer = New-Object ('Microsoft.SqlServer.Management.Smo.Wmi.ManagedComputer') $Server

        Write-Host $Server
        Write-Host "----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
        $SQLServer.Services | select name, type, ServiceAccount, DisplayName, Properties, StartMode, StartupParameters | where {$_.ServiceAccount -like "partners\msscpsql"} | Format-Table
        $ChangeService=$SQLServer.Services | where {$_.ServiceAccount -eq "partners\msscpsql"}
        $UName="partners\msacapintsql01$"
        $PWord=""

        #$ChangeService.SetServiceAccount($UName, $PWord)
        #$ChangeService | select name, type, ServiceAccount, DisplayName, Properties, StartMode, StartupParameters | Format-Table
 
}



 