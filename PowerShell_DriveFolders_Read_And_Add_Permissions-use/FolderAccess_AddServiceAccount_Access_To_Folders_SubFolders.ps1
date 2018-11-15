#Script to given permissions on folders and subfolders for service accounts or users. Change the path and identity as required # Requires Windows PowerShell 3.0


#$drive = "J:\"
#$Acl = (Get-Item $drive).GetAccessControl('Access')
#$identity = "partners\MSACAPPRDSQL01$"
#$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule ($identity,"FullControl","ObjectInherit","None","Allow")
#$Acl.SetAccessRule($Ar)
#Set-Acl $drive $Acl





#C:\Program Files\Microsoft Passport RPS
#C:\Program Files\Microsoft Supportability
#D:\Program Files\Microsoft Supportability
#D:\inetpub



#Service Account or User Identity
$identity = "partners\MSACAPPRDIIS01$"
$basePath = "D:\Program Files\Microsoft Supportability"
#Update Roles, Roles Inheritance Properties as required $accessRule
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule ($identity,"FullControl","ObjectInherit","None","Allow")
foreach($folder in Get-ChildItem -Path $basePath -Recurse -Directory)
{
    $acl = $folder.GetAccessControl("Access")
    
    #To Add new AccessRule
    $acl.AddAccessRule($accessRule)
    #To Update Exisitng
    #$acl.SetAccessRule($accessRule)
    #To Remove Exisitng
    #$acl.RemoveAccessRule($accessRule)
    
    $folder.SetAccessControl($acl)  
    
}

#Roles:
#FullControl
#Modify
#Read
#ReadAndExecute
#ReadData
#Write
#WriteData etc

#ContainerInherit (the ACE is inherited by child containers, like subfolders)
#ObjectInherit (the ACE is inherited by child objects, like files)
#None
#example "ContainerInherit, ObjectInherit"

#InheritOnly (the ACE is propagated to all child objects)
#NoPropagateInherit (the ACE is not propagated to child objects)
#None