#Script - Query Registry by Key

foreach($serverName in Get-Content .\ProdListCY1.txt) 
{
#MSSCPCAT
#MSSCAPAC
$SearchValue = "MSSCAPAC"
#$SearchValue = "MSSCPCAT"
$basePath = "HKLM:\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Supportability"

foreach($folder in Get-ChildItem -Path $basePath -Recurse)
{

$Path = $folder
#$item = Get-ItemProperty -Path $Path
#$item = Invoke-command -computername $serverName -Command {Get-ItemProperty -path $Path}
$item = Invoke-Command -computername -scriptblock {Get-ItemProperty -path $folder}

#Get-ItemProperty -Path $Path

foreach ($prop in $item.psobject.Properties) {
    if($prop.Value -match "$SearchValue") 
    { "Server: $serverName :: Found in Path: $($item.PSPath) , Key: $($prop.Name)" }   
      
    }

}

}