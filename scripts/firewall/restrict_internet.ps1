# === RESTRICT INTERNET (ANTI-BYPASS) ===

Write-Host "Applying firewall restrictions..."

# 🧹 очистка старих правил

Get-NetFirewallRule -DisplayName "Block QUIC" -ErrorAction SilentlyContinue | Remove-NetFirewallRule
Get-NetFirewallRule -DisplayName "Block DNS External" -ErrorAction SilentlyContinue | Remove-NetFirewallRule

# 🔒 1. Блок QUIC (UDP 443 — обход через Chrome/VPN)

New-NetFirewallRule -DisplayName "Block QUIC" -Direction Outbound -Protocol UDP -RemotePort 443 -Action Block

# 🔒 2. Блок зовнішніх DNS (8.8.8.8 і т.д.)

New-NetFirewallRule -DisplayName "Block DNS External" -Direction Outbound -Protocol UDP -RemotePort 53 -Action Block

Write-Host "✅ Firewall restrictions applied"
