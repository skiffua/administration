# === BLOCK VPN PORTS ===

Write-Host "Blocking VPN ports..."

# 🧹 1. Видалити старі правила (якщо вже були)

Get-NetFirewallRule -DisplayName "Block OpenVPN UDP 1194" -ErrorAction SilentlyContinue | Remove-NetFirewallRule
Get-NetFirewallRule -DisplayName "Block WireGuard UDP 51820" -ErrorAction SilentlyContinue | Remove-NetFirewallRule
Get-NetFirewallRule -DisplayName "Block IPSec UDP 500" -ErrorAction SilentlyContinue | Remove-NetFirewallRule
Get-NetFirewallRule -DisplayName "Block IPSec UDP 4500" -ErrorAction SilentlyContinue | Remove-NetFirewallRule

# 🔒 2. Створити нові правила

New-NetFirewallRule -DisplayName "Block OpenVPN UDP 1194" -Direction Outbound -Protocol UDP -RemotePort 1194 -Action Block
New-NetFirewallRule -DisplayName "Block WireGuard UDP 51820" -Direction Outbound -Protocol UDP -RemotePort 51820 -Action Block
New-NetFirewallRule -DisplayName "Block IPSec UDP 500" -Direction Outbound -Protocol UDP -RemotePort 500 -Action Block
New-NetFirewallRule -DisplayName "Block IPSec UDP 4500" -Direction Outbound -Protocol UDP -RemotePort 4500 -Action Block

Write-Host "✅ VPN ports blocked"
