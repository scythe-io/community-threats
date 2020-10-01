# SLOTHFULMEDIA Adversary Emulation Plan

Based on Cyber Threat Intelligence from US-Cert: https://us-cert.cisa.gov/ncas/analysis-reports/ar20-275a

To emulate:
1. Import the threat into SCYTHE
2. Create a campaign from threat
3. Use HTTP or HTTPS over default TCP port (80 or 443 respectively)
4. Set header to Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.75
5. Set Timestamp to 2019-04-29T10:18:34
6. Download the 32-bit EXE and rename to mediaplayer.exe

The real malware appears to only run with local administrator privileges. We have modified it to run with standard user, check for privilege, and only create a service if it is running in high integrity.

File is persistent in %USERPROFILE%\AppData\Roaming\Media\mediaplayer.exe

Steps:
Look for a file called 'Junk9' and will attempt to delete it.
Take a screenshot
The program then looks for a service called 'TaskFrame' and attempts to start it. The 'TaskFrame' service is able to delete, add, or modify registry keys, and start and stop a keylogger program on the system. If the 'TaskFrame' service is already installed and running the program will terminate.

HKLM\System\CurrentControlSet\Control\SessionManager\PendingFileRenameOperations
Data: \??\C:\Users\<user>\AppData\Local\Temp\wHPEO.exe

1. Create, Write, and Delete files.
2. Open a Command Line.
3. Move Files.
4. Enumerate Open Ports.
5. Enumerate Drives.
6. Enumerate Processes by ID, Name, or Privileges.
7. Start and Stop Processes.
8. Enumerate Files and Directories.
9. Open a Named Pipe and Send and Receive Data.
10. Take Screenshots.
11. Inject into User Processes.
12. Enumerate Services.
13. Start/Stop Services.
14. Modify the Registry.
15. Open/Close TCP and UDP Sessions.