#Script - To pull registy folders & sub folders and access details and can be filtered with specific identity(service account)

$identity = "partners\msacapstgiis01$"
$Filteridentity = "partners\*"
$basePath = "HKLM:\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Supportability"
foreach($folder in Get-ChildItem -Path $basePath -Recurse)
{
    $getAcl = $folder.GetAccessControl("Access")
    #See current access on the keys    
   	Write-Output $folder.Name 
	Write-Output $getacl.Access | Where { $_.IdentityReference -like $Filteridentity}
    #with no filter
    #Write-Output $getacl.Access
}