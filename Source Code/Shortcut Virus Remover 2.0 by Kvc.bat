@Echo off
cls
Title Shortcut virus remover Ver.2.0 by Kvc

REM Every Line written After 'REM' Keyword is a comment...
REM 
REM For Making This program more effective...Run it As Administrator...

REM This Program is created for helping and Educational purpose only, it is provided to you under the
REM terms of GNU License... You must got a copy of it with this File, if Not then Search on Google about GNU License
REM 
REM This Program comes with no warranty and Responsibility of any kind of Damage that your can made with it to your system...
REM 

REM Created By : Karanveer chouhan [Kvc]
REM Creation Time: 5:54 AM, 31.1.2016
REM 
REM Get More Programs like this at: 
REM https://batchprogrammers.blogspot.com

REM #TheBATeam

Setlocal Enabledelayedexpansion
Mode 80,25
set Dir=%systemdrive%\system\Shortcut_Virus_Remover_Chest
set Path=%Dir%;%cd%\files;%path%;
Set Msg=

If Not Exist "%Dir%" (
	:First_Run
	MD "%Dir%" 2>Nul
	Rem Setting up all buttons...and saving them to files...as it will be faster to load next time... 
	Call Button.bat "  System Scan  " b0 System_Scan N 1 "  System Scan  " 30 System_Scan_Clicked N 1 "  Drive Scan  " b0 Drive_Scan N 1 "  Drive Scan  " 30 Drive_Scan_Clicked N 1 "Exit" 70 Exit N 1 "Exit" 80 Exit_Clicked N 1 "Help" 70 Help N 1 "Help" 80 Help_Clicked N 1 "Back" a0 Back N 1 "Back" 20 Back_Clicked N 1 "Ok" 70 Ok N 1 "Ok" 80 Ok_Clicked N 1 " Delete " c0 Delete N 1 " Delete " 40 Delete_Clicked N 1 "  Keep  " a0 Keep N 1 "  Keep  " 20 Keep_Clicked N 1 
	For %%a in (System_Scan System_Scan_Clicked Drive_Scan Drive_Scan_Clicked Exit Exit_Clicked Help Help_Clicked Back Back_Clicked Ok Ok_Clicked Delete Delete_Clicked Keep Keep_Clicked) do (echo.!%%a!>"!dir!\%%a.button")
)

Set Rebuilt=N
for %%a in (System_Scan System_Scan_Clicked Drive_Scan Drive_Scan_Clicked Exit Exit_Clicked Help Help_Clicked Back Back_Clicked Ok Ok_Clicked Delete Delete_Clicked Keep Keep_Clicked) do (
	If Exist "!dir!\%%a.button" (Set /p %%a=<"!dir!\%%a.button") else (Title Some files are missing from data base...rebuilding them && set rebuilt=Y)
	)
if /i "%rebuilt%" == "Y" (goto :First_Run)

:Menu
color 07
Cls
REM Starting GUI Printing on the COnsole using batbox.exe extension... 
Batbox /o 70 1 %Exit% /o 60 1 %Help% /o 17 10 %System_Scan% /o 42 10 %Drive_Scan% /o 0 0 /g 20 24 /d "!Msg!"

Set Msg=
For /f "delims=: tokens=1,2,3" %%a in ('batbox /m') do (
	set _Button=%%c
	set X=%%a
	set Y=%%b
	)
if /i "%_Button%" == "1" (
	if %x% geq 60 if %x% leq 68 if %y% geq 1 if %y% leq 3 (
	Batbox /o 60 1 %Help_Clicked% /w 150 /o 60 1 %Help% /w 50
	goto :Help
)
	if %x% geq 70 if %x% leq 78 if %y% geq 1 if %y% leq 3 (
	Batbox /o 70 1 %Exit_Clicked% /w 150 /o 70 1 %Exit% /w 50
	goto :End
)
	if %x% geq 17 if %x% leq 38 if %y% geq 10 if %y% leq 13 (
	Batbox /o 17 10 %System_Scan_Clicked% /w 150 /o 17 10 %System_Scan% /w 50
	Goto :System_Scan
)
	if %x% geq 42 if %x% leq 58 if %y% geq 10 if %y% leq 13 (
	Batbox /o 42 10 %Drive_Scan_Clicked% /w 150 /o 42 10 %Drive_Scan% /w 50
	Goto :Drive_Scan
)
)
goto :Menu

REM Defining Further Sub-Sections...
:Drive_Scan
cls
Set _Choice=
Echo.
Echo. Select Any of The Available Drives From list:
Echo.
Echo.   Label    [Key to Press]
Echo.
For %%A in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) Do (If Exist "%%A:\" (Echo. %%~A: Drive        [%%~A] && Set _Choice=!_Choice!%%~A))
Echo.
Choice /n /c "!_Choice!" /m "Press The Drive Letter to Scan:"
Set _Error=!Errorlevel!
For %%A in (!_Error!) do Set _Drive_Letter=!_Choice:~0,%%A!
Set _Drive_Letter=!_Drive_Letter:~-1!

Call :Remove_Virus_From "!_Drive_Letter!"
Call :Unhide_Files "!_Drive_Letter!"

Set Msg=Applied Actions on !_Drive_Letter!: Drive Successfully...
Goto :Menu


:System_Scan
cls
REM Scanning The Full computer for the Shortcut Virus...
For %%A in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) Do (If Exist "%%A:\" (Call :Remove_Virus_From "%%~A"))
Set Msg=Applied Actions on Whole system Successfully...
Goto :Menu

:Help
cls
color 07
call Box 0 0 19 80 - - 77
batbox /g 34 0 /c 0x78 /d "Help Menu" /g 1 1 /c 0x70 /d "Shortcut Virus Remover ver.2.0 is very Small and easy to use Program, as all" /g 1 2 /c 0x70 /d "of its options are necessary and easy to Understand." /g 1 4 /c 0x70 /d "In The 'System Scan' option, The program will scan into all the available " /g 1 5 /c 0x70 /d "Drives on the system... then ask for the appropriate action for suspecious " /g 1 6 /c 0x70 /d "files..." /g 1 8 /c 0x70 /d "While in the '" /g 15 8 /c 0x7e /d "Drive Scan" /g 9 4 /c 0x7e /d "System Scan" /g 25 8 /c 0x70 /d "' option, The Program only scan into the Specified " /g 1 9 /c 0x70 /d "Drive and after scanning... Program will automatically Unhide all the Hidden" /g 1 10 /c 0x70 /d "files which are hidden because of the Shortcut Virus..." /g 1 12 /c 0x76 /d "We Hope that you'll Like Our Work... Visit more Like this Program at:" /g 1 13 /c 0x79 /d "https://batchprogrammers.blogspot.com" /g 1 15 /c 0x78 /d "Thanks for using this Program. Show your Love at Our Blog (Batch Archive)." /g 1 17 /c 0x7e /d "#TheBATeam" /c 0x0f /g 27 24 /d "Press Any Key to Go Back..."
Pause >nul
Goto :Menu

:End
Exit /b 0

REM -------------------------------------------------------------------------------------
REM                                 Function Definition Section...
REM _____________________________________________________________________________________


REM Function to remove shortcut Virus is below...
REM Created by kvc, At 2:32 AM, 31.1.2016
:Remove_Virus_From [Drive_Letter]
color 07
Cls
Setlocal Enabledelayedexpansion
Set "Drive_Letter=%~1"
Set Drive_Letter=!Drive_Letter::=!:

Call Box 27 1 3 26 - - 99
batbox /c 0x9f /g 31 2 /d "Scanning !Drive_Letter! Drive... "

Cd /d "!Drive_Letter!"
cd /
Dir /s /b /a:h *.Vbs> "!Tmp!\_SVR_Database.db" 2>nul
Dir /s /b *.Vbs>> "!Tmp!\_SVR_Database.db" 2>nul
Dir /s /b /a:h *.Vbe>> "!Tmp!\_SVR_Database.db" 2>nul
Dir /s /b *.Vbe>> "!Tmp!\_SVR_Database.db" 2>nul

For /l %%A in (1,1,4) do Taskkill /f /im Wscript.exe 2>nul
Set _Counter=0
For /f "Tokens=*" %%A in (!Tmp!\_SVR_Database.db) do (Set /a _Counter+=1)

Set _New_Counter=1
For /f "Tokens=*" %%A in (!Tmp!\_SVR_Database.db) do (
	Call Box 20 6 13 40 - - 77
	Set _Path=%%~sA
	Set "_String=/c 0x07 /g 50 5 /d "!_New_Counter! / !_Counter! " /c 0x70 /g 21 7 /d "Name: %%~nA" /g 21 9 /d "Type:" /g 27 9 /c 0x78 /d "%%~xA" /c 0x70 /g 21 11 /d "Size: %%~zA Bytes" /g 21 13 /d "Path: !_Path:~3,31!~" /g 21 15 /d "Attributes: %%~aA" /g 21 17 /d "Time: %%~tA""
	Batbox !_String! /o 25 20 !Delete! /o 46 20 !Keep!
	Call :Sub_Menu_Function "%%~A"
	set /a _New_Counter+=1
)
Goto :EOF


:Sub_Menu_Function [File]
Setlocal Enabledelayedexpansion
:Sub_Menu
	For /f "delims=: tokens=1,2,3" %%a in ('Batbox /m') do (
		set _Button=%%c
		set X=%%a
		set Y=%%b
	)
	For /f %%A in ("%~1") do (
		Set _Name=%%~nA
		Set _Type=%%~xA
		)
	if /i "!_Button!" == "1" (
		if !x! geq 25 if !x! leq 37 if !y! geq 20 if !y! leq 23 (
		Batbox /o 25 20 !Delete_Clicked! /w 150 /o 25 20 !Delete!
		Attrib -r -s -a -h "%~1" >nul
		If Not Exist "!Dir!\!Date!" (MD "!Dir!\!Date!")
		Move /y "%~1" "!Dir!\!Date!" 2>nul
		Ren "!Dir!\!Date!\!_Name!!_Type!" "!_Name!!_Type!.neutrilized" 2>nul
		Reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "!_Name!" /f 2>nul
		Goto :EOF
	)

		if !x! geq 46 if !x! leq 58 if !y! geq 20 if !y! leq 23 (Goto :EOF)
)
Goto Sub_Menu


:Unhide_Files [Drive_Letter]
color 07
Cls
Setlocal Enabledelayedexpansion
Set "Drive_Letter=%~1"
Set Drive_Letter=!Drive_Letter::=!:

Call Box 27 1 3 26 - - aa
batbox /c 0xa0 /g 31 2 /d "Unhiding !Drive_Letter! Drive... "

Cd /d "!Drive_Letter!"
cd /
Attrib -r -s -a -h *.* /s /d >nul 2>nul
Goto :Eof