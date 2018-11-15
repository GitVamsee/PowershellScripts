foreach($serverName in Get-Content .\ProdListC01.txt) 
{

Write-Host "IIS status on $serverName..."

invoke-command -computername $serverName {cd C:\Windows\System32\; ./cmd.exe /c "iisreset /status" }
Write-Host "========================================================================================"
Write-Host ""
}


