# === LOCK PROXY SETTINGS ===

Write-Host "Locking proxy settings..."

# 🧱 ВКЛЮЧИТИ ПРОКСІ (заміни на свій!)

$proxy = "192.168.1.10:3128"

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d $proxy /f

# 🔒 Заборонити зміну проксі через UI

reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v Proxy /t REG_DWORD /d 1 /f

# 🔒 Вимкнути зміну налаштувань мережі

reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Restrictions" /v NoConnectionsSettings /t REG_DWORD /d 1 /f

Write-Host "✅ Proxy locked"
