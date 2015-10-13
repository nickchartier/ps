#* FileName:  	Get-Uptime.ps1
#*=============================================================================
#* Script Name: Get-Uptime
#* Created:     02/27/2015
#* Author:      Nick Chartier
#*=============================================================================

#*=============================================================================
#* Purpose: WMI Function that calculates uptime based on Last Boot Time
#*
#*=============================================================================

[CmdletBinding()]
Param(
  [Parameter(Mandatory=$True,ValueFromPipeline=$True,Position=1)]
   $ComputerName
)

ForEach ($Computer in $ComputerName)
{
	If (Test-Connection -ComputerName $Computer -quiet)
	{
		$comp = Get-WmiObject -ComputerName $Computer Win32_OperatingSystem
		$uptime = $comp.ConvertToDateTime($comp.LocalDateTime) - $comp.ConvertToDateTime($comp.LastBootUpTime)
		$uptime
	}
}
