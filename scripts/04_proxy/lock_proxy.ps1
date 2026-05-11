# === LOCK PROXY SETTINGS ===
$proxy_address = "192.168.14.240"
$proxy_port = 3128
$full_proxy = "$proxy_address:$proxy_port"

Write-Host "--- Locking proxy settings ---" -ForegroundColor Red

# 1. Системні налаштування Windows (Edge, Chrome, System)
Write-Host "[1/3] Configuring Windows System Proxy..."
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d $full_proxy /f

# 2. Заборона зміни налаштувань через інтерфейс (GPO style)
Write-Host "[2/3] Restricting UI Access..."
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v Proxy /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Restrictions" /v NoConnectionsSettings /t REG_DWORD /d 1 /f

# 3. Налаштування Firefox (через user.js у профілях)
Write-Host "[3/3] Configuring Firefox Profiles..."
$ffPath = "$env:APPDATA\Mozilla\Firefox\Profiles"
if (Test-Path $ffPath) {
    $profiles = Get-ChildItem $ffPath | Where-Object { $_.PSIsContainer }
    foreach ($profile in $profiles) {
        $userJs = Join-Path $profile.FullName "user.js"
        $ffSettings = @(
            "user_pref('network.proxy.type', 1);",
            "user_pref('network.proxy.http', '$proxy_address');",
            "user_pref('network.proxy.http_port', $proxy_port);",
            "user_pref('network.proxy.ssl', '$proxy_address');",
            "user_pref('network.proxy.ssl_port', $proxy_port);",
            "user_pref('network.proxy.share_proxy_settings', true);"
        )
        $ffSettings | Out-File $userJs -Encoding utf8 -Force
        Write-Host "      - Configured: $($profile.Name)"
    }
} else {
    Write-Host "      ! Firefox profiles not found." -ForegroundColor Yellow
}

Write-Host "✅ Proxy locked successfully. Restart browsers to apply." -ForegroundColor Green