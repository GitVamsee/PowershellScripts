#Look for any registry key or value on list of remote machines 

#Update filter value as desired
Param($Filter = "MSSCAPAC",$Srv = $env:computerName,$regpath ="SOFTWARE\Microsoft\Supportability\")
#MSSCTCAT

function Check-RegKeys 
{
Param($regkey,$Server)
$ServerKey = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey("LocalMachine", $Server)
$SubKey = $ServerKey.OpenSubKey($regkey,$false)
If(!($SubKey)){Return}
$SubKeyValues = $SubKey.GetValueNames()
if($SubKeyValues)
{
foreach($SubKeyValue in $SubKeyValues)
{
$Key = @{n="Key";e={$SubKey.Name -replace
"HKEY_LOCAL_MACHINE\\",""}}
$ValueName = @{n="ValueName";e={$SubKeyValue}}
$Value = @{n="Value";e={$_}}
$SubKey.GetValue($SubKeyValue) | ?{$_ -match $Filter} | Select-Object $Key,$ValueName,$Value 
}
}
$SubKeyName = $SubKey.GetSubKeyNames()
foreach($subkey in $SubKeyName)
{
$SubKeyName = "$regkey\$subkey"
Check-RegKeys $SubKeyName $Srv
}
}

$ServerList = Get-Content ProdServerList.txt
Foreach ($Server in $ServerList)
{
$Srv = $Server
Write-Host "============================================================="
$Server
Write-Host "============================================================="
Check-RegKeys $regPath $Srv
}