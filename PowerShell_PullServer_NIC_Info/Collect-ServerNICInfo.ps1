<#
Collect-ServerInfo.ps1 - PowerShell script to collect information about Windows servers network information
#>


#[CmdletBinding()]

#Param (

 #   [parameter(ValueFromPipeline=$True)]
 #   [string[]]$ComputerName

#)

Begin
{
    #Initialize
    Write-Verbose "Initializing"

}

Process
{

foreach($line in Get-Content .\input.txt) 
{
    $ComputerName = $line        
    $Text1 =$ComputerName + ':'
    $text1 | Add-Content 'Result.txt'
   
    

    $htmlreport = @()
    $htmlbody = @()
    $htmlfile = "$($ComputerName).html"
    $spacer = "<br />"

    #---------------------------------------------------------------------
    # Do 10 pings and calculate the fastest response time
    # Not using the response time in the report yet so it might be
    # removed later.
    #---------------------------------------------------------------------
    
    try
    {
        $bestping = (Test-Connection -ComputerName $ComputerName -Count 10 -ErrorAction STOP | Sort ResponseTime)[0].ResponseTime
    }
    catch
    {
        Write-Warning $_.Exception.Message
        $bestping = "Unable to connect"
    }

    if ($bestping -eq "Unable to connect")
    {
        if (!($PSCmdlet.MyInvocation.BoundParameters[“Verbose”].IsPresent))
        {
            Write-Host "Unable to connect to $ComputerName"
        }

        "Unable to connect to $ComputerName"
            $Text1 = "Unable to connect to $ComputerName"
            $text1 | Add-Content 'Result.txt'
    }
    else
    {

        #---------------------------------------------------------------------
        # Collect network interface information and convert to HTML fragment
        #---------------------------------------------------------------------    

   
        Write-Verbose "Collecting network interface information"

        try
        {
            $nics = @()
            $nicinfo = @(Get-WmiObject Win32_NetworkAdapter -ComputerName $ComputerName -ErrorAction STOP | Where {$_.PhysicalAdapter} |
                Select-Object Name,AdapterType,MACAddress,
                @{Name='ConnectionName';Expression={$_.NetConnectionID}})

            $nwinfo = Get-WmiObject Win32_NetworkAdapterConfiguration -ComputerName $ComputerName -ErrorAction STOP |
                Select-Object Description, DHCPServer,  
                @{Name='IpAddress';Expression={$_.IpAddress -join '; '}},  
                @{Name='IpSubnet';Expression={$_.IpSubnet -join '; '}},  
                @{Name='DefaultIPgateway';Expression={$_.DefaultIPgateway -join '; '}},  
                @{Name='DNSServerSearchOrder';Expression={$_.DNSServerSearchOrder -join '; '}}
            
          
            foreach ($nic in $nicinfo)
            {                       
            
                $nicObject = New-Object PSObject
                $nicObject | Add-Member NoteProperty -Name "Connection Name" -Value $nic.connectionname
                $nicObject | Add-Member NoteProperty -Name "Adapter Name" -Value $nic.Name
                $nicObject | Add-Member NoteProperty -Name "Type" -Value $nic.AdapterType
                $nicObject | Add-Member NoteProperty -Name "MAC" -Value $nic.MACAddress
                $nicObject | Add-Member NoteProperty -Name "Enabled" -Value $nic.Enabled
                $nicObject | Add-Member NoteProperty -Name "Speed (Mbps)" -Value $nic.Speed
        
                $ipaddress = ($nwinfo | Where {$_.Description -eq $nic.Name}).IpAddress
                $nicObject | Add-Member NoteProperty -Name "IPAddress" -Value $ipaddress

               
                   #if($nic.connectionname.Contains('PEFL') -or $nic.connectionname.Contains('PEBL') -or $nic.connectionname.Contains('EFL')  -or $nic.connectionname.Contains('EBL') -or $nic.connectionname.Contains('Ethernet') -or $nic.connectionname.Contains('Ethernet 2') -or $nic.connectionname.Contains('TEFL') -or $nic.connectionname.Contains('TEBL'))
                   #{                                       
                    $Text = $Text +  '/' + $nic.connectionname                    
                   #}
                                                     
                
                $nics += $nicObject
             }
             
             $Text | Add-Content 'Result.txt' 
             $Text = ''
                    
        }
        catch
        {
            Write-Warning $_.Exception.Message
            $htmlbody += "<p>An error was encountered. $($_.Exception.Message)</p>"
            $htmlbody += $spacer

            $Text1 = $_.Exception.Message
            $text1 | Add-Content 'Result.txt'
        }
        
    }

  }
}

End
{
    #Wrap it up
    Write-Verbose "=====> Finished <====="
}
