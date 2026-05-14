# === DISABLE APPLOCKER ===

Stop-Service AppIDSvc -Force
Set-Service AppIDSvc -StartupType Disabled

Write-Host "✅ AppLocker disabled"
