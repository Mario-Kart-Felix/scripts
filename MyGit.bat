
echo 1.codes
echo 2.DotC repositories
echo 3.games
echo 4.PyJAMAx64
echo 5.scripts
choice /C abcde /N /M "-> "
if %errorlevel% ==1 (
	call :one
	goto :eof)
if %errorlevel% ==2 (
	call :two
	goto :eof
) 
if %errorlevel% ==3 (
	call :three
	goto :eof
) 
if %errorlevel% == 4 (
	call :four
	goto :eof
) 
if %errorlevel% == 5 (
	call :five
	goto :eof
)
goto :eof

:one
cd codes 
call :treeProcess
echo Codes Uploaded
sleep 4s
goto :eof

:two
cd DotCTheProgrammingClub
call :treeProcess
cls
echo DotC codes uploaded
sleep 4s
goto :eof

:three
cd games
call :treeProcess
cls
echo games uploaded
sleep 4s
goto :eof

:four
cd PyJAMAx64
call :treeProcess
cls
echo Project - PyJAMA uploaded
sleep 4s
goto :eof

:five
cd scripts
call :treeProcess
cls
echo Scripts uploaded
sleep 4s
goto :eof

:upload
 git add -A
 git commit -m "Auto Upload"
 git push origin master
 goto :eof

:treeProcess  
call :upload
for /D %%d in (*) do (
    cd %%d%
    call :treeProcess    
    cd ..
)
