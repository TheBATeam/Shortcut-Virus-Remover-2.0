@Echo off

::The following Function is created by kvc...don't modify it...if you don't know what are you doing...
::it takes following arguments...
:: it is the ver.3.0 of Box function... and it's faster than previous function... #kvc
rem :: Unwanted parameters are removed ... (i.e. Dialogue Box...) Make the color code for FG and BG same for siply getting a dialogue box...

rem [%1 = X-ordinate]
rem [%2 = Y-co_ordinate]
rem [%3 = height of box]
rem [%4 = width of box] 
rem [%5 = width From where to separate box,if don't specified or specified '-' (minus),then box will not be separated.]
rem [%6 = Background element of Box,if not specified or specified '-' (minus),then no background will be shown...It should be a single Character...]
rem [%7 = the colour Code for the Box,e.g. fc,08,70,07 etc...don't define it if you want default colour...or type '-' (minus) for no color change...]

rem #kvc

rem :: Visit https://bathprogrammers.blogspot.com for more extensions / plug-ins like this.... :]
rem #TheBATeam

If /i "%~1" == "" (goto :help)
If /i "%~1" == "/?" (goto :help)
If /i "%~1" == "-h" (goto :help)
If /i "%~1" == "help" (goto :help)
If /i "%~1" == "-help" (goto :help)

If /i "%~1" == "ver" (echo.3.0&&goto :eof)


If /i "%~2" == "" (goto :help)
If /i "%~3" == "" (goto :help)
If /i "%~4" == "" (goto :help)

:Box
setlocal Enabledelayedexpansion
set _string=
set "_SpaceWidth=/d ""
set _final=

set x_val=%~1
set y_val=%~2
set sepr=%~5
if /i "!sepr!" == "-" (set sepr=)
set char=%~6
if /i "!char!" == "-" (set char=)
if defined char (set char=!char:~0,1!) ELSE (set "char= ")
set color=%~7
if defined color (if /i "!color!" == "-" (set color=) Else (set "color=/c 0x%~7"))

set _Hor_line=/a 196
set _Ver_line=/a 179
set _Top_sepr=/a 194
set _Base_sepr=/a 193
set _Top_left=/a 218
set _Top_right=/a 191
set _Base_right=/a 217
set _Base_left=/a 192

set /a _char_width=%~4-2
set /a _box_height=%~3-2

for /l %%A in (1,1,!_char_width!) do (
	if /i "%%A" == "%~5" (
	set "_string=!_string! !_Top_sepr!"
	set "_SpaceWidth=!_SpaceWidth!" !_Ver_line! /d ""
	) ELSE (
	set "_string=!_string! !_Hor_line!"
	set "_SpaceWidth=!_SpaceWidth!!char!"
	)
)

set "_SpaceWidth=!_SpaceWidth!""
set "_final=!_final! /g !x_val! !y_val! !_Top_left! !_string! !_Top_right!"
set /a y_val+=1

for /l %%A in (1,1,!_box_height!) do (
set "_final=!_final! /g !x_val! !y_val! !_Ver_line! !_SpaceWidth! !_Ver_line!"
set /a y_val+=1
)

set "_final=!_final! /g !x_val! !y_val! !_Base_left! !_string:194=193! !_Base_right!"

endlocal && batbox.exe %color% %_final% /c0x07
goto :eof


:help
Echo.
Echo. This function helps in Adding a little GUI effect into your batch program...
echo. It Prints simple box on the cmd console at specified X Y co-ordinate...
echo.
echo. Syntax: call Box [X] [Y] [Height] [Width] [Sepration] [BG_Char] [color]
echo. Syntax: call Box [help ^| /^? ^| -h ^| -help]
echo. Syntax: call Box ver
echo.
echo. Where:-
echo. X		= X-ordinate of top-left corner of box
echo. Y		= Y-co_ordinate of top-left corner of box
echo. Height		= height of box
echo. Width		= width of box
echo. Sepration	= width From where to separate box,if don't specified or
echo.		  specified '-' (minus),then box will not be separated.
echo. BG_char	= Background element of Box,if not specified or specified
echo.		  '-' (minus),then no background will be shown...It should be
echo.		  a single Character...
echo. color		= the color Code for the Box,e.g. fc,08,70,07 etc...
echo.		  Don't define it if you want default colour...or type '-'
echo.		  (minus) for no color change...
echo. ver		= Version of Box function
echo.
echo. This version 3.0 of Box function is 70%% faster than the previous ver.
echo. As it uses batbox.exe and calls it only once at the end of calculation...
echo. Visit https://batchprogrammers.blogspot.com for more...
echo. #Kvc with #TheBATeam
goto :eof