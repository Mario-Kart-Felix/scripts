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
	call :upload
	cd ..
	cd in_sessions
	del *.exe
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
 echo Everything's all set up, boss.
 timeout /t 2 /nobreak > NUL
 goto :eof
:upload
 cls
 echo CURRENT DIRECTORY-
 echo %cd%
 echo PULLING LATEST REMOTE BRANCH
 git pull
 echo  .
 echo ADDING FILES AND
 git add -A
 echo COMMITTING CHANGES
 git commit -m "Uploaded via GitBot v0.4"
 echo  .
 choice /N /M "READY ? : "
 if %errorlevel% == 1 (
 echo GOING LIVE...
 echo  .
 git push origin master
 timeout /t 2 /nobreak > NUL
 cls
 goto :eof 
) else (
 cls
 echo COMMITS CANCELLED TO GITHUB.
 timeout /t 2 /nobreak > NUL)
