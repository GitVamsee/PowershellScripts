#reads server name from text file  and writes filtered service accounts to a file

foreach($serverName in Get-Content .\Serverslist.txt) 
{

$serverName >> 'ServiceAccounts.log'
Get-WmiObject Win32_Service -ComputerName $serverName | Where-Object {$_.startname -ne "localSystem" } | Where-Object {$_.startname -ne "NT Service\MSSQLFDLauncher" } | Where-Object {$_.startname -ne "NT AUTHORITY\LocalService" } |Where-Object {$_.startname -ne "NT AUTHORITY\NetworkService" } | select @{N='Service';E={$_.name}}, @{N='ServiceAccount';E={$_.startname}} | Format-Table -AutoSize  >> .\ServiceAccounts.log

}

#Get-WmiObject Win32_Service -ComputerName CY1PQCAPJOB02 | Where-Object {$_.startname -ne "localSystem" }| Where-Object {$_.startname -ne "NT AUTHORITY\LocalService" } |Where-Object {$_.startname -ne "NT AUTHORITY\NetworkService" } | select startname, name | Format-List

