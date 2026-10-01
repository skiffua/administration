@echo off
chcp 65001 >nul

echo ===================================================
echo    РОЗБЛОКУВАННЯ зміни фону для student
echo ===================================================
echo.

:: 1. Знаходимо SID користувача student
echo [1/3] Пошук SID користувача student...
for /f "tokens=2 delims==" %%S in ('wmic useraccount where "name='student' and localaccount='true'" get sid /value ^| find "="') do set "SID=%%S"

if not defined SID (
    echo [ПОМИЛКА] Користувача 'student' не знайдено на цьому ПК!
    echo.
    pause
    exit /b 1
)
echo     Знайдено SID: %SID%

:: 2. Видалення ключів блокування (NoDispBackgroundPage та NoChangingWallPaper)
echo [2/3] Видалення ключів з реєстру...
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "NoDispBackgroundPage" /f >nul 2>&1
reg delete "HKU\%SID%\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "NoDispBackgroundPage" /f >nul 2>&1

reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /v "NoChangingWallPaper" /f >nul 2>&1
reg delete "HKU\%SID%\Software\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /v "NoChangingWallPaper" /f >nul 2>&1

:: 3. Оновлення політик та перезапуск Explorer
echo [3/3] Перезапуск системного інтерфейсу...
gpupdate /force >nul 2>&1
taskkill /f /im SystemSettings.exe >nul 2>&1
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 1 >nul
start explorer.exe

echo.
echo ===================================================
echo    [ОК] Можливість змінювати фон повністю відновлено!
echo ===================================================
echo.

pause
exit /b 0