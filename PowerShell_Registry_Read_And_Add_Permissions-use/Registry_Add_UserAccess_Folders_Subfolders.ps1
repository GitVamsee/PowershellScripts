#Script - Add access to registry folders and subfolders for a service account - recursive
#System.Security.AccessControl.RegistryAccessRule:
    #ReadKey - query registry name/value pairs
    #ReadPermissions - open and copy the access rules
    #FullControl - Control over registry keys

$identity = "partners\MSACAPPRDIIS01$"
$basePath = "HKLM:\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Supportability"
$accessRule = New-Object System.Security.AccessControl.RegistryAccessRule ($identity,"FullControl","None","None","Allow")
foreach($folder in Get-ChildItem -Path $basePath -Recurse)
{
    $acl = $folder.GetAccessControl("Access")
    $acl.AddAccessRule($accessRule)
    $acl |Set-Acl -Path HKLM:\$folder      
}
