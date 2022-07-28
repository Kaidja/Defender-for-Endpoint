#Check if the Defender AV is in Passive, Not Running or EDR Block Mode.
Get-MpComputerStatus | Select-Object -ExpandProperty AMRunningMode

#Get the Windows Defender AV service path
Get-CimInstance -ClassName Win32_Service -Filter "Name='WinDefend'" | Select-Object -Property PathName

#Get Windows Defender information directly from WMI
Get-CimInstance -Namespace "ROOT/Microsoft/Windows/Defender"-ClassName MSFT_MpComputerStatus 

#Check if the third-party AV still installed
Get-CimInstance -Namespace "ROOT\SecurityCenter2" -ClassName AntiVirusProduct

#Windows Defender should run under the C:\ProgramData folder.If this folder is empty, then something is wrong.
$MDEVersions = Get-ChildItem -Directory -Path "C:\programdata\Microsoft\Windows Defender\Platform"
$MDECount = $MDEVersions | Measure-Object
If($MDECount.Count -eq 0){

    Write-Output -InputObject "BROKEN"
}
Else{
    Write-Output -InputObject "NOTBROKEN"
}

#Check Windows Server 2019 and 2022 Windows Defender Feature
$DefenderAVRole = Get-WindowsFeature -Name "Windows-Defender"
If($DefenderAVRole.InstallState -eq "Installed"){

    Write-Host -Object "OK"
}
Else{
    Write-Host -Object "NOTOK"
}

#Check Windows Server 2016 Windows Defender Feature
$DefenderAVRole = Get-WindowsFeature -Name "Windows-Defender-Features"
If($DefenderAVRole.InstallState -eq "Installed"){

    Write-Host -Object "OK"
}
Else{
    Write-Host -Object "NOTOK"
}
