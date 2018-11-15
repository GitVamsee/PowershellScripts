foreach($serverName in Get-Content .\ProdListC01.txt) 
{

Write-Host "Restarting IIS without force on $serverName..."
Write-Host ""

#invoke-command -computername $serverName {cd C:\Windows\System32\; ./cmd.exe /c "iisreset /restart" }


If ($LASTEXITCODE -ge 0)
{
    #In case of any failures re-run the command again

    Write-Host "Failure Exit Code = $LASTEXITCODE"
    Write-Host "Retrying"
 #   invoke-command -computername $serverName {cd C:\Windows\System32\; ./cmd.exe /c "iisreset /restart" }
 
} 
Write-Host "IIS Restarted on $serverName"
Write-Host "================================"

}



