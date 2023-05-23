chcp 936
cls
@echo off & setlocal enabledelayedexpansion
goto start

:start
if not exist "warp.exe" echo È±ÉÙ warp.exe ³ÌÐò & pause & exit
if not exist "ips-v4.txt" echo È±ÉÙ IPV4 Êý¾Ý ips-v4.txt & pause & exit
if not exist "ips-v6.txt" echo È±ÉÙ IPV6 Êý¾Ý ips-v6.txt & pause & exit
goto main

:main
title WARP Endpoint IP Ò»¼üÓÅÑ¡½Å±¾
set /a menu=1
echo #############################################################
echo #                WARP Endpoint IP Ò»¼üÓÅÑ¡½Å±¾              #
echo # ×÷Õß: MisakaNo ¤Î Ð¡ÆÆÕ¾                                  #
echo # ²©¿Í: https://blog.misaka.rest                            #
echo # GitHub ÏîÄ¿: https://github.com/Misaka-blog               #
echo # GitLab ÏîÄ¿: https://gitlab.com/Misaka-blog               #
echo # Telegram ÆµµÀ: https://t.me/misaka_noc                    #
echo # Telegram Èº×é: https://t.me/misaka_noc_chat               #
echo # YouTube ÆµµÀ: https://www.youtube.com/@misaka-blog        #
echo #############################################################
echo.
echo 1. WARP IPv4 Endpoint IP ÓÅÑ¡
echo 2. WARP IPv6 Endpoint IP ÓÅÑ¡
echo -------------
echo 0. ÍË³ö
echo.
set /p menu=ÇëÊäÈëÑ¡Ïî (Ä¬ÈÏ%menu%):
if %menu%==0 exit
if %menu%==1 title WARP IPv4 Endpoint IP ÓÅÑ¡ & set filename=ips-v4.txt & goto getv4
if %menu%==2 title WARP IPv6 Endpoint IP ÓÅÑ¡ & set filename=ips-v6.txt & goto getv6
cls
goto main

:getv4
for /f "delims=" %%i in (%filename%) do (
set !random!_%%i=randomsort
)
for /f "tokens=2,3,4 delims=_.=" %%i in ('set ^| findstr =randomsort ^| sort /m 10240') do (
call :randomcidrv4
if not defined %%i.%%j.%%k.!cidr! set %%i.%%j.%%k.!cidr!=anycastip&set /a n+=1
if !n! EQU 100 goto getip
)
goto getv4

:randomcidrv4
set /a cidr=%random%%%256
goto :eof

:getv6
for /f "delims=" %%i in (%filename%) do (
set !random!_%%i=randomsort
)
for /f "tokens=2,3,4 delims=_:=" %%i in ('set ^| findstr =randomsort ^| sort /m 10240') do (
call :randomcidrv6
if not defined [%%i:%%j:%%k::!cidr!] set [%%i:%%j:%%k::!cidr!]=anycastip&set /a n+=1
if !n! EQU 100 goto getip
)
goto getv6

:randomcidrv6
set str=0123456789abcdef
set /a r=%random%%%16
set cidr=!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!:!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!:!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!:!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
goto :eof

:getip
del ip.txt > nul 2>&1
for /f "tokens=1 delims==" %%i in ('set ^| findstr =randomsort') do (
set %%i=
)
for /f "tokens=1 delims==" %%i in ('set ^| findstr =anycastip') do (
echo %%i>>ip.txt
)
for /f "tokens=1 delims==" %%i in ('set ^| findstr =anycastip') do (
set %%i=
)

warp
del ip.txt > nul 2>&1
echo Çë°´ÈÎÒâ¼ü¹Ø±Õ´°¿Ú
pause > nul
exit
