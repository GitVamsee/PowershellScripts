#reads server name from text file and writes AppPool Service Accounts to text file. Add/Create ServersList.txt with server details in current location. Requires PsExec
try
{

$line = '--------------------------------------------'
foreach($serverName in Get-Content .\ServersList.txt) 
{

$serverName | Add-Content 'AppPoolServiceAccounts.txt'
$line | Add-Content 'AppPoolServiceAccounts.txt'
psexec -nobanner /accepteula \\$serverName c:\windows\system32\inetsrv\appcmd list apppools /text:processModel.userName | Add-Content .\AppPoolServiceAccounts.txt

#Below cmd writes all the content of apppools to file
#psexec \\$serverName c:\windows\system32\inetsrv\appcmd list apppools /text:* | Add-Content .\AppPoolServiceAccounts.txt
$line | Add-Content 'AppPoolServiceAccounts.txt'

}
}
catch
{

}