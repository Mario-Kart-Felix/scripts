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
	cls
	call :upload
	call :done
	goto :eof)
if %errorlevel% ==2 (
	cd DotCTheProgrammingClub
	cd assignment_sols
	del *.exe
	cls
	call :upload
	cd ..
	cd in_sessions
	del *.exe
	cls
	call :upload
	cd ..
	call :done
	goto :eof
) 
if %errorlevel% ==3 (
	cd games
	call :upload
	call :done
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
	call :done
	goto :eof
) 
if %errorlevel% == 5 (
	cd scripts
	call :upload
	call :done
	goto :eof
)

:done 
 sleep 1s
 echo Everything's all set up, boss.
 sleep 2s
 goto :eof
:upload
 echo CURRENT DIRECTORY-
 pwd
 echo PULLING LATEST REMOTE BRANCH
 git pull
 echo DONE.
 echo ADDING FILES AND
 git add -A
 echo COMMITTING CHANGES
 git commit -m "Auto Upload"
 choice /N /M "Ready ? : "
 if %errorlevel% == 1 (
 echo GOING LIVE...
 git push origin master
 )
 sleep 2s