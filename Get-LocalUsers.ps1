$Computers = (Get-Content .\computerList.txt)
#$Computers = "lab01","goliath","lab0101"

Foreach ($Computer in $Computers)
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

