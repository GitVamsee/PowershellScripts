#Pull all AppPools corresponding identity, password and other detals

$ServerName = "CO2PQCAPWBSFE02.partners.extranet.microsoft.com"
try{
Import-Module WebAdministration


$AppPoolName = Get-WebApplication
$list = @()
foreach ($AppPool in get-childitem IIS:\AppPools\)
{

#Pull only app pools which are being run with partners identity
if($AppPool.processModel.userName -like "partners*")
{

#Skipping CCP related AppPools
if(!($AppPool.name -like "ccp*"))
{

$name = "IIS:\AppPools\" + $AppPool.name
$item = @{}
$item.AppPoolName = $AppPool.name
$item.Version = (Get-ItemProperty $name managedRuntimeVersion).Value
$item.State = (Get-WebApplication -Name $AppPool.name).Value
$item.UserIdentityType = $AppPool.processModel.identityType
$item.Username = $AppPool.processModel.userName
$item.Password = $AppPool.processModel.password

$obj = New-Object PSObject -Property $item
$list += $obj

}

}
}

}catch
{
$Errormsg = "Error in Line: " + $_.Exception.Line + ". " + $_.Exception.GetType().FullName + ": " + $_.Exception.Message + " Stacktrace: " + $_.Exception.StackTrace
$Errormsg
}

$list | select AppPoolName,UserIdentityType,Username,State,Password | format-table -AutoSize 
$list | select AppPoolName,UserIdentityType,Username,State,Password | format-table -AutoSize  >  .\$ServerName.txt

