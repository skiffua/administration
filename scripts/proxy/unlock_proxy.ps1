# === UNLOCK PROXY SETTINGS ===

Write-Host "Unlocking proxy settings..."

# ❌ Вимкнути проксі

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f

# 🔓 Дозволити зміну

reg delete "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v Proxy /f
reg delete "HKCU\Software\Policies\Microsoft\Internet Explorer\Restrictions" /v NoConnectionsSettings /f

Write-Host "✅ Proxy unlocked"
