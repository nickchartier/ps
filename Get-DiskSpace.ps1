#* FileName:  	Get-DiskSpace.ps1
#*=============================================================================
#* Script Name: Get-DiskSpace
#* Created:     07/10/2014
#* Author:      Nick Chartier
#*=============================================================================

#*=============================================================================
#* Purpose: WMI Function that enumerates logical drives and reports on size
#*          and free space.
#*
#*=============================================================================

[CmdletBinding()]
Param(
  [Parameter(Mandatory=$True,ValueFromPipeline=$True,Position=1)]
   $ComputerNames,
	
   [Parameter(Mandatory=$false)]
   [string]$FilePath
)

ForEach ($Computer in $ComputerNames)
{
	If (Test-Connection -ComputerName $Computer -quiet)
	{
		Get-WmiObject -ComputerName $Computer Win32_LogicalDisk | Select-Object Name, @{LABEL='Size (GB)';EXPRESSION={"{0:N2}" -f ($_.Size/1GB)}}, @{LABEL='Free (GB)';EXPRESSION={"{0:N2}" -f ($_.FreeSpace/1GB)}} | FT $computer, *
	}
}
