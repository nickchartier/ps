#* FileName:  	Get-LocalUsers.ps1
#*=============================================================================
#* Script Name: Get-LocalUsers
#* Updated:		10/13/2015
#* Created:     07/10/2014
#* Author:      Nick Chartier
#*=============================================================================

#*=============================================================================
#* Purpose: WMI Function that enumerates local users and writes out a file
#*=============================================================================

[CmdletBinding()]
Param(
  [Parameter(Mandatory=$True,ValueFromPipeline=$True,Position=1)]
   $ComputerNames,
)

Foreach ($Computer in $ComputerNames)
{

    if (Test-Connection -ComputerName $Computer -Count 2 -Delay 1 -quiet)
    {
        $localUsers = Get-WmiObject Win32_UserAccount -ComputerName $Computer -Filter "LocalAccount=true"
        Foreach ($user in $localUsers)
        {
            Write-Output "$Computer, $($user.name)" | Out-File -Append .\localUsers.txt
        }
    }
}

