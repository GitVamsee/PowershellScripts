Param(
[Parameter(Mandatory)]
$fileGuid
)

#$fileGuid ='bd3a00a3-5db2-4655-893b-f90f53478ee8'
$basePath ='\\co1mscapprodfs.partners.extranet.microsoft.com\css_data\'
$filePath = $BasePath + $fileGuid.SubString(0,1) + "\" + $fileGuid.SubString(1,1) + "\" + $fileGuid.SubString(2,1) +"\"+$fileGuid
$filepath
$destpath ='\\cy1capfilprod.partners.extranet.microsoft.com\catops\v-vamsek\'

Copy-Item -Path $filePath  -Destination $destpath

$x = Copy-Item -Path $filePath  -Destination $destpath -PassThru -ErrorAction silentlyContinue
if ($x) { $x }
else { "Copy failure"} 

<#
 if ($lastexitcode -eq 0)
 {
      write-host "Robocopy succeeded"
 }
else
{
      write-host "Robocopy failed with exit code:" $lastexitcode
}

#>
