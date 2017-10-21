@echo off
echo 1.codes
echo 2.DotC repositories
echo 3.games
echo 4.PyJAMAx64
echo 5.scripts
choice /C abcde /N /M "-> "
if %errorlevel% ==1 (
	cd codes
	del *.exe
	call :upload
	goto :eof)
if %errorlevel% ==2 (
	cd DotCTheProgrammingClub
	cd assignment_sols
	del *.exe
	call :upload
	cd ..
	cd in_sessions
	del *.exe
	call :upload
	cd ..
	goto :eof
) 
if %errorlevel% ==3 (
	cd games
	call :upload
	goto :eof
) 
if %errorlevel% == 4 (
	cd PyJAMAx64
	cd CLEANER
	call :upload
	cd ..
	cd SWITCHES
	call :upload
	cd ..
	cd master
	call :upload
	cd ..
	cd misc
	call :upload
	cd ..
	goto :eof
) 
if %errorlevel% == 5 (
	cd scripts
	call :upload
	goto :eof
)

:upload
 pwd
 git pull
 git add -A
 git commit -m "Auto Upload"
 git push origin master
 sleep 2s
 cls