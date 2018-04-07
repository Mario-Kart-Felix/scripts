@echo off
setlocal
echo Remember to press enter only AFTER update is complete
pause
set /p "var1=Enter URL: " %=% pause
if defined var1 set "var1=%var1:"=%"
set "var2=%date:/=-%"
set "var3=%%(title)s.%%(ext)s"
cd /
cd Downloads
y.exe "%var1%" -ci -o "%var2%\%var3%" -f 140 -x --    no-mtime --add-metadata --write-thumbnail  
start .
rem del y.exe
pause
endlocal