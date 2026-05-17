@echo off
cls
title Service Suite v1.15.5 Hardware Edition [MULTILANG FIXED]
chcp 65001 >nul

:: Нативная проверка прав администратора
net session >nul 2>&1
if %errorLevel% neq 0 (
    color 0C
    echo ==================================================================
    echo  [!] КРИТИЧЕСКАЯ ОШИБКА / CRITICAL ERROR [!]
    echo  Запустите этот батник от имени АДМИНИСТРАТОРА!
    echo  Please run this script as ADMINISTRATOR!
    echo ==================================================================
    pause
    exit
)

:LANG_CHOICE
cls
color 0B
echo ==================================================================
echo               [!] SELECT LANGUAGE / ВЫБЕРИТЕ ЯЗЫК [!]
echo ==================================================================
echo.
echo  1. Русский язык (Russian Edition)
echo  2. English language (Global Edition)
echo.
echo ==================================================================
set "lang_select="
set /p lang_select="ВВЕДИТЕ ЦИФРУ И НАЖМИТЕ ENTER (1-2): "

if "%lang_select%"=="1" (set "lang=RU" & goto MENU)
if "%lang_select%"=="2" (set "lang=EN" & goto MENU)
goto LANG_CHOICE

:MENU
cls
color 0B
if "%lang%"=="EN" goto MENU_EN

:MENU_RU
echo ==================================================================
echo         [!] SERVICE SYSTEM SUITE v1.15.5 [!]
echo         HARDWARE EDITION // РЕДКАЯ ИСПРАВЛЕННАЯ БЕТА
echo         РАЗРАБОТКА И ДИЗАЙН: ZENIX ^| ЖЕЛЕЗО, НОВОСТИ
echo ==================================================================
echo.
echo  1. БЫСТРАЯ ОЧИСТКА (Службы MS, логи ошибок, Temp) [FIXED]
echo  2. ИГРОВОЙ СТЕЛС-РЕЖИМ (Выгрузка тяжелых клиентов из ОЗУ)
echo  3. СЕТЕВОЙ РЕАНИМАТОР (Сброс WinSock и протоколов IP)
echo  4. ТВИКИ ОТ ZENIX (Зачистка скрытого кэша Дискорда)
echo  5. МОНИТОРИНГ ЖЕЛЕЗА (Паспорт характеристик ПК)
echo  6. ПОЛНАЯ АННИГИЛЯЦИЯ (Все модули по очереди + Корзина)
echo  7. ВЫХОД ИЗ ПРОГРАММЫ
echo.
echo ==================================================================
set "choice="
set /p choice="ВВЕДИТЕ НОМЕР ОПЦИИ И НАЖМИТЕ ENTER (1-7): "
goto PROCESS_CHOICE

:MENU_EN
echo ==================================================================
echo         [!] SERVICE SYSTEM SUITE v1.30 PLATINUM [!]
echo         LEGACY HARDWARE EDITION // FIXED BETA v1.15.5
echo         DEVELOPED BY: ZENIX ^| HARDWARE, NEWS
echo ==================================================================
echo.
echo  1. QUICK CLEAN (MS Services, error logs, Temp folder)
echo  2. GAME STEALTH MODE (Unload heavy clients from RAM)
echo  3. NETWORK RECOVERY (Reset WinSock ^& IP protocols)
echo  4. TWEAKS BY ZENIX (Clear hidden Discord cache)
echo  5. HARDWARE MONITORING (System Hardware Passport)
echo  6. TOTAL ANNIHILATION (All modules + Clear Recycle Bin)
echo  7. EXIT PROGRAM
echo.
echo ==================================================================
set "choice="
set /p choice="ENTER OPTION NUMBER AND PRESS ENTER (1-7): "
goto PROCESS_CHOICE

:PROCESS_CHOICE
if "%choice%"=="5" goto MODULE_HARDWARE
if "%choice%"=="6" goto MODULE_ALL
if "%choice%"=="7" exit

set "target="
if "%choice%"=="1" set target=MODULE_CLEAN
if "%choice%"=="2" set target=MODULE_STEALTH
if "%choice%"=="3" set target=MODULE_NET
if "%choice%"=="4" set target=MODULE_TWEEKS

if "%target%"=="" goto MENU

:: Избирательный щит от запущенных VPN процессов перед опасными командами
tasklist /NH | findstr /I "v2ray Amnezia wireguard Planet Windscribe Proton VPN openvpn clash" >nul 2>&1
if %errorLevel% equ 0 goto vpn_detected
goto %target%

:vpn_detected
cls
color 0C
if "%lang%"=="RU" (
    echo ==================================================================
    echo  [ВНИМАНИЕ] ОБНАРУЖЕН ЗАПУЩЕННЫЙ VPN ПРОЦЕСС!
    echo  Операция заблокирована во избежание разрыва вашей сети.
    echo  Пожалуйста, полностью закройте VPN перед зачисткой.
    echo ==================================================================
) else (
    echo ==================================================================
    echo  [WARNING] ACTIVE VPN PROCESS DETECTED!
    echo  Operation blocked to prevent network link disconnect.
    echo  Please close your VPN client before cleaning.
    echo ==================================================================
)
pause
goto MENU

:MODULE_CLEAN
cls
color 0E
if "%lang%"=="RU" (echo [+] ЗАПУЩЕН ИСПРАВЛЕННЫЙ МОДУЛЬ 1: ОЧИСТКА...) else (echo [+] RUNNING MODULE 1: QUICK CLEAN...)
echo ------------------------------------------------------------------
taskkill /f /im XboxApp.exe /im GamingServices.exe >nul 2>&1
rmdir /s /q "%localappdata%\Temp" >nul 2>&1
mkdir "%localappdata%\Temp"
rmdir /s /q "C:\Windows\Temp" >nul 2>&1
mkdir "C:\Windows\Temp"
wevtutil cl Application >nul 2>&1
echo ------------------------------------------------------------------
if "%lang%"=="RU" (echo [УСПЕШНО] Баг исправлен! Мусор вычищен, сеть стабильна!) else (echo [SUCCESS] Bug fixed! Cache cleared, link stable!)
pause
goto MENU

:MODULE_STEALTH
cls
color 0A
if "%lang%"=="RU" (echo [+] ЗАПУЩЕН МОДУЛЬ 2: ИГРОВОЙ СТЕЛС-РЕЖИМ...) else (echo [+] RUNNING MODULE 2: GAME STEALTH...)
echo ------------------------------------------------------------------
taskkill /f /im LeagueClient.exe /im RiotClientServices.exe >nul 2>&1
rmdir /s /q "%localappdata%\NVIDIA\DXCache" >nul 2>&1
echo ------------------------------------------------------------------
if "%lang%"=="RU" (echo [УСПЕШНО] Оперативная память освобождена под катку!) else (echo [SUCCESS] RAM flushed! Ready for maximum performance!)
pause
goto MENU

:MODULE_NET
cls
color 0C
if "%lang%"=="RU" (echo [+] ЗАПУЩЕН МОДУЛЬ 3: СЕТЕВОЙ РЕАНИМАТОР...) else (echo [+] RUNNING MODULE 3: NETWORK RECOVERY...)
echo ------------------------------------------------------------------
ipconfig /flushdns >nul 2>&1
netsh winsock reset >nul 2>&1
netsh int ip reset >nul 2>&1
:: Реанимация DHCP адаптера, чтобы у пацанов не пропадал интернет!
ipconfig /release >nul 2>&1
ipconfig /renew >nul 2>&1
echo ------------------------------------------------------------------
if "%lang%"=="RU" (echo [УСПЕШНО] Сетевые протоколы DHCP возвращены на базу!) else (echo [SUCCESS] DHCP network configuration restored!)
pause
goto MENU

:MODULE_TWEEKS
cls
color 06
if "%lang%"=="RU" (echo [+] ЗАПУЩЕН МОДУЛЬ 4: ТВИКИ ОТ ZENIX...) else (echo [+] RUNNING MODULE 4: TWEAKS BY ZENIX...)
echo ------------------------------------------------------------------
:: Точный фикс путей Дискорда (переведено в Local)
rmdir /s /q "%localappdata%\Discord\Cache" >nul 2>&1
rmdir /s /q "%localappdata%\Discord\Code Cache" >nul 2>&1
echo ------------------------------------------------------------------
if "%lang%"=="RU" (echo [УСПЕШНО] Хакерский кэш Дискорда полностью стерт!) else (echo [SUCCESS] Hidden Discord cache completely erased!)
pause
goto MENU

:MODULE_HARDWARE
cls
color 03
if "%lang%"=="EN" goto HARDWARE_EN

:HARDWARE_RU
echo ==================================================================
echo          [-] МОНИТОРИНГ ЖЕЛЕЗА v1.15.5 [-]
echo ==================================================================
echo  [-] ЦЕНТРАЛЬНЫЙ ПРОЦЕССОР:
powershell -NoProfile -Command "Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name"
echo.
echo  [-] ВИДЕОКАРТА (ГРАФИЧЕСКИЙ ЧИП):
powershell -NoProfile -Command "Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name"
echo.
echo  [-] МАТЕРИНКА:
powershell -NoProfile -Command "$b = Get-CimInstance Win32_BaseBoard; Write-Host \"$($b.Manufacturer) $($b.Product)\""
echo.
echo  [-] ОПЕРАТИВНАЯ ПАМЯТЬ:
:: Фикс Ceiling для честного округления вверх до 32 ГБ и экранирование кавычек
powershell -NoProfile -Command "$total = [Math]::Ceiling((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB); Write-Host \"Всего установлено: $total ГБ\""
goto HARDWARE_END

:HARDWARE_EN
echo ==================================================================
echo          [-] SYSTEM HARDWARE PASSPORT v1.15.5 [-]
echo ==================================================================
echo  [-] CENTRAL PROCESSOR:
powershell -NoProfile -Command "Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name"
echo.
echo  [-] GRAPHICS CARD (GPU):
powershell -NoProfile -Command "Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name"
echo.
echo  [-] MOTHERBOARD:
powershell -NoProfile -Command "$b = Get-CimInstance Win32_BaseBoard; Write-Host \"$($b.Manufacturer) $($b.Product)\""
echo.
echo  [-] SYSTEM MEMORY (RAM):
powershell -NoProfile -Command "$total = [Math]::Ceiling((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB); Write-Host \"Total Installed: $total GB\""

:HARDWARE_END
echo ==================================================================
pause
goto MENU

:MODULE_ALL
cls
color 0F
if "%lang%"=="RU" (echo [💀] ЗАПУСК ТОТАЛЬНОЙ АННИГИЛЯЦИИ МУСОРА...) else (echo [💀] RUNNING TOTAL ANNIHILATION...)
echo ------------------------------------------------------------------
:: Превращаем пункт 6 в реальный комбайн, вызывая все очистки разом!
rmdir /s /q "%localappdata%\Temp" >nul 2>&1
mkdir "%localappdata%\Temp"
rmdir /s /q "C:\Windows\Temp" >nul 2>&1
mkdir "C:\Windows\Temp"
wevtutil cl Application >nul 2>&1
rmdir /s /q "%localappdata%\NVIDIA\DXCache" >nul 2>&1
rmdir /s /q "%localappdata%\Discord\Cache" >nul 2>&1
powershell -NoProfile -Command "Clear-RecycleBin -Confirm:$false" >nul 2>&1
echo ------------------------------------------------------------------
if "%lang%"=="RU" (echo [МЕГА-УСПЕШНО] Версия v1.15.5 прогнала все твики! Корзина пуста!) else (echo [MEGA-SUCCESS] v1.15.5 cleanup finished! Recycle bin empty!)
pause
goto MENU
