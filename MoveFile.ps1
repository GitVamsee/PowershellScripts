Param(
[Parameter(Mandatory)]
$fileGuid
)

#$fileGuid ='bd3a00a3-5db2-4655-893b-f90f53478ee8'
#$basePath ='\\co1mscapprodfs.partners.extranet.microsoft.com\css_data\'
$basePath ='\\cy1capfilprod.partners.extranet.microsoft.com\catops\v-vamsek\css_data\'
$destPath ='\\cy1capfilprod.partners.extranet.microsoft.com\catops\v-vamsek\'


        #Setting file folderpath based on the first 3 char of fileGuid
        $fileFolderPath = $basePath + $fileGuid.SubString(0,1) + "\" + $fileGuid.SubString(1,1) + "\" + $fileGuid.SubString(2,1)
        $filePath = $basePath + $fileGuid.SubString(0,1) + "\" + $fileGuid.SubString(1,1) + "\" + $fileGuid.SubString(2,1) +"\"+$fileGuid


        if (!(Test-Path $filePath) )
        {
            Write-host "File:$fileGuid Not Found in FilePath: $fileFolderPath"-ForegroundColor Red 
            exit
        }

    $x = Move-Item -Path $filePath  -Destination $destPath -PassThru -ErrorAction silentlyContinue

        if ($x) 
        {        
        Write-host "File:$fileGuid Moved to: $destPath "-ForegroundColor Green }
        else 
        { 
        Write-host "File:$fileGuid Move failed"-ForegroundColor Red } 
