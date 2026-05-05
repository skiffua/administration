# === REMOVE FIREWALL RESTRICTIONS ===

Write-Host "Removing firewall restrictions..."

Get-NetFirewallRule -DisplayName "Block QUIC" -ErrorAction SilentlyContinue | Remove-NetFirewallRule
Get-NetFirewallRule -DisplayName "Block DNS External" -ErrorAction SilentlyContinue | Remove-NetFirewallRule

Write-Host "✅ Restrictions removed"
