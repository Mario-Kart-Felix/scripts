Set WshShell = CreateObject("WScript.Shell") 
WshShell.Run chr(34) & "ping 127.0.0.1 -n 100 > nul" & Chr(34), 0
WshShell.Run chr(34) & "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\cleantemp.bat" & Chr(34), 0
Set WshShell = Nothing

