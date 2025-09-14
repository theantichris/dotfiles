<# setup-ssh-minimal.ps1
   Installs OpenSSH Server and sets PowerShell as the default shell
#>

# Require admin
if (-not ([Security.Principal.WindowsPrincipal] `
      [Security.Principal.WindowsIdentity]::GetCurrent()
  ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  Write-Host "Run this script as Administrator." -ForegroundColor Red
  exit 1
}

# Install OpenSSH Server
$cap = Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Server*'
if ($cap.State -ne 'Installed') {
  Write-Host "Installing OpenSSH Server..." -ForegroundColor Cyan
  Add-WindowsCapability -Online -Name 'OpenSSH.Server~~~~0.0.1.0'
}

# Start sshd and enable automatic start
Start-Service sshd -ErrorAction SilentlyContinue
Set-Service sshd -StartupType Automatic

# Allow firewall port 22
if (-not (Get-NetFirewallRule -DisplayName 'OpenSSH-Server-In-TCP-22' -ErrorAction SilentlyContinue)) {
  New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP-22' `
    -DisplayName 'OpenSSH-Server-In-TCP-22' `
    -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
}

# Set default shell to PowerShell 7 if available, else fallback to Windows PowerShell
$pwsh = "$Env:ProgramFiles\PowerShell\7\pwsh.exe"
if (Test-Path $pwsh) {
  $shell = $pwsh
}
else {
  $shell = "$Env:WINDIR\System32\WindowsPowerShell\v1.0\powershell.exe"
}

$regPath = 'HKLM:\SOFTWARE\OpenSSH'
if (-not (Test-Path $regPath)) { New-Item $regPath -Force | Out-Null }
New-ItemProperty -Path $regPath -Name DefaultShell -Value $shell -PropertyType String -Force

Write-Host "✅ SSH Server installed and default shell set to: $shell" -ForegroundColor Green
