@echo off

echo.
echo.
echo         ________________________
echo        /  __/__   __/__   ____  \	 :: Change
echo       /  /    /  /    /  /___/  /	 :: Internet
echo      /  /    /  /    /  _______/ 	 :: Protocol
echo     /  /____/  /____/  /                    Address
echo     \____/_______/_____/
echo.
echo            [ Coded by TR3X ]
echo.
echo.

net session >nul 2>&1
if %errorLevel% == 0 (
	goto get_interface
) else (
	echo [!] Run the Script as Admin
	echo.
	EXIT /B
)

:get_interface
echo.
echo [*] Interface Name (Wi-Fi / ethernet)
:interface
Set interface=
set /p interface="> "
echo.

if [%interface%] == [] (
	set interface=Wi-Fi
)
	
echo [+] Interface : %interface%
echo.

:get_ip
echo.
echo [*] Enter New IP Address
:ip
Set ip=
set /p ip="> "
echo.

if [%ip%] == [] (
	echo [!] IP Address is Required
	echo.
	goto get_ip
)

echo [+] IP Address : %ip%
echo.

:get_subnet
echo.
echo [*] Enter Subnet Mask (Default : 255.255.255.0)
:subnet
Set subnet=
set /p subnet="> "
echo.

if [%subnet%] == [] (
	set subnet=255.255.255.0
)

echo [+] Subnet Mask : %subnet%

:get_gateway
echo.
echo [*] Enter Default Gateway (Default : 192.168.1.1)
:gateway
Set gateway=
set /p gateway="> "
echo.

if [%gateway%] == [] (
	set gateway=192.168.1.1
)

echo [+] Default Gateway : %gateway%
echo.

:get_dns
echo [*] DNS (Default : 8.8.8.8)
:dns
Set dns=
set /p dns="> "
echo.

if [%dns%] == [] (
	set dns=8.8.8.8
)

echo.

netsh interface ipv4 set address name="%interface%" static %ip% %subnet% %gateway%
netsh interface ipv4 set dns name="%interface%" static %dns%

cls
echo [+] Reconnecting...
timeout /T 6 /NOBREAK >nul

ipconfig

echo.
echo.
echo [+] IP Address Successfully Changed to : %ip%
echo.
EXIT /B
