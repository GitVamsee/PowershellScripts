#Update/Change AppPools corresponding identity, recycle app pool

try{
Import-Module WebAdministration

$AppPoolName = Get-WebApplication

foreach ($AppPool in get-childitem IIS:\AppPools\)
{

#Pull only app pools which are being run with partners identity
if($AppPool.processModel.userName -like "partners*")
{

#Skipping CCP related AppPools
if(!($AppPool.name -like "ccp*"))

#ToChangeSpecific AppPool
#if(($AppPool.name -eq "CcpAuthzManagementServiceAppPool"))

{

$AppPool.processModel.userName = "partners\MSACAPPRDIIS01$"
#gMSA, no password required. For other identities input password
#$AppPool.processModel.password = ""
$AppPool | set-item 
$AppPool.Recycle()

}

}
}

}catch
{
$Errormsg = "Error in Line: " + $_.Exception.Line + ". " + $_.Exception.GetType().FullName + ": " + $_.Exception.Message + " Stacktrace: " + $_.Exception.StackTrace
$Errormsg
}


