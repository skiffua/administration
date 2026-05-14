# === UNLOCK PROXY SETTINGS ===
Write-Host "--- Unlocking proxy settings ---" -ForegroundColor Green

# 1. Вимкнення системного проксі
Write-Host "[1/3] Disabling Windows System Proxy..."
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f

# 2. Зняття обмежень інтерфейсу
Write-Host "[2/3] Restoring UI Access..."
reg delete "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v Proxy /f 2>$null
reg delete "HKCU\Software\Policies\Microsoft\Internet Explorer\Restrictions" /v NoConnectionsSettings /f 2>$null

# 3. Очищення налаштувань Firefox
Write-Host "[3/3] Resetting Firefox Profiles..."
$ffPath = "$env:APPDATA\Mozilla\Firefox\Profiles"
if (Test-Path $ffPath) {
    $profiles = Get-ChildItem $ffPath | Where-Object { $_.PSIsContainer }
    foreach ($profile in $profiles) {
        $userJs = Join-Path $profile.FullName "user.js"
        if (Test-Path $userJs) {
            Remove-Item $userJs -Force
            Write-Host "      - Removed restrictions: $($profile.Name)"
        }
    }
}

Write-Host "✅ Proxy unlocked. Restart browsers to apply." -ForegroundColor Green