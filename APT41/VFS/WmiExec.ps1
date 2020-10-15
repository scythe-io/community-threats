<#        
    .SYNOPSIS
     Execute command remotely and capture output, using only WMI.
     Copyright (c) Noxigen LLC. All rights reserved.
     Licensed under GNU GPLv3.

    .DESCRIPTION
    This is proof of concept code. Use at your own risk!
    
    Execute command remotely and capture output, using only WMI.
    Does not reply on PowerShell Remoting, WinRM, PsExec or anything
    else outside of WMI connectivity.
    
    .LINK
    https://github.com/OneScripter/WmiExec
    
    .EXAMPLE
    PS C:\> .\WmiExec.ps1 -ComputerName SFWEB01 -Command "gci c:\; hostname"

    .NOTES
    ========================================================================
         NAME:		WmiExec.ps1
         
         AUTHOR:	Jay Adams, Noxigen LLC
         			
         DATE:		6/11/2019
         
         Create secure GUIs for PowerShell with System Frontier.
         https://systemfrontier.com/powershell
    ==========================================================================
#>
Param(
	[string]$ComputerName,
	[Parameter(ValueFromPipeline=$true)]
	[string]$Command
)

function CreateScriptInstance([string]$ComputerName)
{
	# Check to see if our custom WMI class already exists
	$classCheck = Get-WmiObject -Class Noxigen_WmiExec -ComputerName $ComputerName -List -Namespace "root\cimv2"
	
	if ($classCheck -eq $null)
	{
		# Create a custom WMI class to store data about the command, including the output.
		Write-Host "Creating WMI class..."
		$newClass = New-Object System.Management.ManagementClass("\\$ComputerName\root\cimv2",[string]::Empty,$null)
		$newClass["__CLASS"] = "Noxigen_WmiExec"
		$newClass.Qualifiers.Add("Static",$true)
		$newClass.Properties.Add("CommandId",[System.Management.CimType]::String,$false)
		$newClass.Properties["CommandId"].Qualifiers.Add("Key",$true)
		$newClass.Properties.Add("CommandOutput",[System.Management.CimType]::String,$false)
		$newClass.Put() | Out-Null
	}
	
	# Create a new instance of the custom class so we can reference it locally and remotely using this key
	$wmiInstance = Set-WmiInstance -Class Noxigen_WmiExec -ComputerName $ComputerName
	$wmiInstance.GetType() | Out-Null
	$commandId = ($wmiInstance | Select-Object -Property CommandId -ExpandProperty CommandId)
	$wmiInstance.Dispose()
	
	# Return the GUID for this instance
	return $CommandId
}

function GetScriptOutput([string]$ComputerName, [string]$CommandId)
{
	$wmiInstance = Get-WmiObject -Class Noxigen_WmiExec -ComputerName $ComputerName -Filter "CommandId = '$CommandId'"
	$result = ($wmiInstance | Select-Object CommandOutput -ExpandProperty CommandOutput)
	$wmiInstance | Remove-WmiObject
	return $result
}

function ExecCommand([string]$ComputerName, [string]$Command)
{
	#Pass the entire remote command as a base64 encoded string to powershell.exe
	$commandLine = "powershell.exe -NoLogo -NonInteractive -ExecutionPolicy Unrestricted -WindowStyle Hidden -EncodedCommand " + $Command
	$process = Invoke-WmiMethod -ComputerName $ComputerName -Class Win32_Process -Name Create -ArgumentList $commandLine
	
	if ($process.ReturnValue -eq 0)
	{
		$started = Get-Date
		
		Do
		{
			if ($started.AddMinutes(2) -lt (Get-Date))
			{
				Write-Host "PID: $($process.ProcessId) - Response took too long."
				break
			}
			
			# TODO: Add timeout
			$watcher = Get-WmiObject -ComputerName $ComputerName -Class Win32_Process -Filter "ProcessId = $($process.ProcessId)"
			
			Write-Host "PID: $($process.ProcessId) - Waiting for remote command to finish..."
			
			Start-Sleep -Seconds 1
		}
		While ($watcher -ne $null)
		
		# Once the remote process is done, retrieve the output
		$scriptOutput = GetScriptOutput $ComputerName $scriptCommandId
		
		return $scriptOutput
	}
}

function Main()
{
	$commandString = $Command
	
	# The GUID from our custom WMI class. Used to get only results for this command.
	$scriptCommandId = CreateScriptInstance $ComputerName
	
	if ($scriptCommandId -eq $null)
	{
		Write-Error "Error creating remote instance."
		exit
	}
	
	# Meanwhile, on the remote machine...
	# 1. Execute the command and store the output as a string
	# 2. Get a reference to our current custom WMI class instance and store the output there!
		
	$encodedCommand = "`$result = Invoke-Command -ScriptBlock {$commandString} | Out-String; Get-WmiObject -Class Noxigen_WmiExec -Filter `"CommandId = '$scriptCommandId'`" | Set-WmiInstance -Arguments `@{CommandOutput = `$result} | Out-Null"
	
	$encodedCommand = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($encodedCommand))
	
	Write-Host "Running the below command on: $ComputerName..."
	Write-Host $commandString
	
	$result = ExecCommand $ComputerName $encodedCommand
	
	Write-Host "Result..."
	Write-Output $result
}

Main