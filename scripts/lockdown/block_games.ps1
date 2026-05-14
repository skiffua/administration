# === APPLY APPLOCKER POLICY (Games + VPN) ===

Write-Host "Applying AppLocker policy..."

# 1. Увімкнути службу AppLocker

Set-Service AppIDSvc -StartupType Automatic
Start-Service AppIDSvc

# 2. Застосувати XML політику

Set-AppLockerPolicy -XmlPolicy "\SERVER\school-control\scripts\applocker.xml" -Merge

# 3. Оновити політики

gpupdate /force

Write-Host "✅ AppLocker policy applied"
