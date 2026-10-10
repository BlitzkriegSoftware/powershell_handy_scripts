<#
    .SYNOPSIS
        This script is used to perform weekly maintenance tasks on the system.

#>
#Requires -RunAsAdministrator 

$FLAG = [Environment]::IsPrivilegedProcess
if (-not $FLAG) {
    Write-Host "This script must be run as an administrator." -ForegroundColor Red
    exit 2
}

Repair-WindowsImage -Online -StartComponentCleanup
Repair-WindowsImage -Online -RestoreHealth

sfc /scannow

Clear-RecycleBin -Force -ErrorAction SilentlyContinue

Remove-Item -Path "$env:USERPROFILE\AppData\Local\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$env:windir\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

Stop-Service -Name "wuauserv" -Force
Remove-Item -Path "$env:windir\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
Start-Service -Name "wuauserv"

Clear-DnsClientCache

Update-MpSignature
Start-MpScan -ScanType FullScan
# Offline deep scan
# Start-MpWDOScan

Start-Process -FilePath "$env:windir\System32\mrt.exe" -ArgumentList "/q /f:y" -Wait
Write-Output "Log in: $env:windir\debug\mrt.log"

Optimize-Volume -DriveLetter C -Trim -Verbose

Write-Output "Y" | chkdsk /scan /perf /sdcleanup /forceofflinefix  /offlinescanandfix c:
exit 0