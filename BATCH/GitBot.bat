@echo off
echo AVAILABLE REPOSITORIES :-
dir /A:D /O /B
echo """""""""""""
set /p repo=Repository : 
 cd "%repo%*"
 call :upload
 call :done
 goto :eof

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
 set /p Input=Commit Message : 
 cls
 git commit -m "%Input%"
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
