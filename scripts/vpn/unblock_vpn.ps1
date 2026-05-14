# === UNBLOCK VPN PORTS ===

Write-Host "Unblocking VPN ports..."

# Видалити всі правила блокування VPN

Get-NetFirewallRule -DisplayName "Block OpenVPN UDP 1194" -ErrorAction SilentlyContinue | Remove-NetFirewallRule
Get-NetFirewallRule -DisplayName "Block WireGuard UDP 51820" -ErrorAction SilentlyContinue | Remove-NetFirewallRule
Get-NetFirewallRule -DisplayName "Block IPSec UDP 500" -ErrorAction SilentlyContinue | Remove-NetFirewallRule
Get-NetFirewallRule -DisplayName "Block IPSec UDP 4500" -ErrorAction SilentlyContinue | Remove-NetFirewallRule

Write-Host "✅ VPN ports unblocked"

