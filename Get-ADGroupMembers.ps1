#* FileName:  	Get-ADGroupMembers.ps1
#*=============================================================================
#* Script Name: Get-ADGroupMembers
#* Created:     09/05/2014
#* Author:      Nick Chartier
#*=============================================================================

#*=============================================================================
#* Purpose: Get a list of members in a group and check the status of their 
#*			CIT accounts.
#*=============================================================================

[CmdletBinding()]
Param(
  [Parameter(Mandatory=$True,ValueFromPipeline=$True,Position=1)]
   $GroupName
)

Write-Host "*******************************************"
Write-Host "*                                         *"
Write-Host "*******************************************"

$result = Get-ADGroup $GroupName -Properties *

$result.DistinguishedName
$result.Members | get-aduser -Properties * | FT -a Displayname, PasswordNeverExpires, PasswordLastSet, LastLogonDate
