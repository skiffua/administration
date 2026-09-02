@echo off
chcp 65001 >nul

echo ===================================================
echo   Застосування блокування фону для student
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

:: 2. Внесення ключів блокування сторінки та ActiveDesktop
echo [2/3] Запис ключів реєстру...
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "NoDispBackgroundPage" /t REG_DWORD /d 1 /f >nul
reg add "HKU\%SID%\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "NoDispBackgroundPage" /t REG_DWORD /d 1 /f >nul

reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /v "NoChangingWallPaper" /t REG_DWORD /d 1 /f >nul
reg add "HKU\%SID%\Software\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /v "NoChangingWallPaper" /t REG_DWORD /d 1 /f >nul

:: 3. Оновлення політик та перезапуск Explorer
echo [3/3] Перезапуск системного інтерфейсу...
gpupdate /force >nul 2>&1
taskkill /f /im SystemSettings.exe >nul 2>&1
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 1 >nul
start explorer.exe

echo.
echo ===================================================
echo   [ОК] Зміни успішно застосовано!
echo ===================================================
echo.

:: Вікно термінала не закриватиметься до натискання клавіші
pause
exit /b 0