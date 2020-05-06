@echo off

:: This Function is created by Kvc At '1:06 AM 5/16/2015'
:: Use 'Button /?' for help...on using this function...

:: this function prints a Button like interface / image on cmd console...using batbox.exe,getlen.exe
:: you have to specify the text of the button... like "OK, cancel, Retry etc..." as 1st parameter...
:: if the name contains spaces...then use Double quotes to write the name of button in 1st parameter...

:: in 2nd parameter you have to specify the color of the button...in Hex-code...use 'color /?' for help...
:: and the full prepared code of button...that can be executed with batbox.exe in the cmd console is returned
:: in the 3rd parameter...which is nothing, but the name of the variable...e.g. result etc.

:: E.g. : Call button.bat "Button 1" 0a result_1 Y 1 "Button 2" 02 result_2 N 2
:: The Prepared code for the "Button_1" and "Button_2" will be saved in the variables named 'result_1' and 'result_2'...
:: and now you can simply put the button's code anywhere on cmd console using the "Batbox.exe" plugin...

:: E.g. : batbox.exe /o 10 15 %result_1% /o 30 15 %result_2%

if /i "%~1" == "/?" (goto help)
if /i "%~1" == "-h" (goto help)
if /i "%~1" == "--Help" (goto help)



:loop_of_button_fn
setlocal enabledelayedexpansion
set "button_text=%~1"
if not defined button_text (goto :EOF)
set color=%~2
call :corresponding_shade_color "%color:~1,1%" corresponding_shade_1
call :corresponding_shade_color "%color:~0,1%" corresponding_shade_2
set corresponding_shade=%corresponding_shade_2%%corresponding_shade_1%
if not defined color (goto :EOF)
getlen.exe "%button_text%"
set len=%errorlevel%
if not defined len (Echo. getlen.exe is not found in your system... &&pause&&exit /b)
set /a button_width=4+%len%
set "button_text=  %button_text%  "
set gradient=
if /i "%~4" == "Y" set gradient=/c 0x%corresponding_shade% 
if /i "%~5" == "2" (set "element=/a 196")
if /i "%~5" == "3" (set "element=/a 205")
for /l %%a in (1,1,%button_width%) do (set "horizontal_line=!element! !horizontal_line!" && set "free_space= !free_space!")
set /a button_width+=1
if /i "%~5" == "1" (set "code=/c 0x%color% /g 0 0 /d "!free_space!" /g 0 1 /d "!button_text!" %gradient%/g 0 2 /d "!free_space!" /c 0x07")
if /i "%~5" == "2" (set "code=/c 0x%color% /g 0 0 /a 218 !horizontal_line!/a 191 /g 0 1 /a 179 /d "!button_text!" /a 179 %gradient%/g 0 2 /a 192 !horizontal_line! /a 217 /c 0x07")
if /i "%~5" == "3" (set "code=/c 0x%color% /g 0 0 /a 201 !horizontal_line!/a 187 /g 0 1 /a 186 /d "!button_text!" /a 186 %gradient%/g 0 2 /a 200 !horizontal_line! /a 188 /c 0x07")
endlocal && set %~3=%code%
for /l %%a in (1,1,5) do shift /1
goto :loop_of_button_fn

:help
echo.
echo.Usage:
echo.Call button.bat "[Name]" [color] [Variable] [Y^|N] [Type] "[Name 2]" [color 2] 
echo.					[Variable 2] [Y^|N] [Type]...
echo. 
echo.You can make more than one button...by this function...only in single line...
echo.
echo.where...
echo. [Name] 		: Name of the Button / Button Text
echo. [Color]		: Color code of the button
echo. [variable]	: It returns the code of the button which will execute in the
echo.					Batbox.exe ...
echo. [Y^|N]		: Will enable or disable The gradient on the button...
echo. [Type]		: It can only take 1,2,3 as its values...
echo.
echo. E.g. : Call button.bat "Button 1" 0a result_1 Y 1 "Button 2" 02 result_2 N 2
echo. 		batbox.exe /o 10 15 %%result_1%% /o 30 15 %%result_2%%
echo.
echo.  Created by Kvc ... Goto 'batchprogrammers.blogspot.in' for help ^& more...
echo.


:corresponding_shade_color
if /i "%~1" == "a" set %~2=2
if /i "%~1" == "b" set %~2=3
if /i "%~1" == "c" set %~2=4
if /i "%~1" == "d" set %~2=5
if /i "%~1" == "e" set %~2=6
if /i "%~1" == "f" set %~2=7
for /l %%a in (0,1,9) do if /i "%~1" == "%%a" set %~2=8
goto :eof