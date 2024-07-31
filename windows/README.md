
```
# install choco
# start terminal by running as Administrator
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco install git -y

PS C:\Users\coder> (Get-Command New-PSSession).ParameterSets.Name
ComputerName
Uri
VMId
VMName
Session
ContainerId
UseWindowsPowerShellParameterSet
SSHHost
SSHHostHashParam


Subsystem powershell c:/progra~1/powershell/7/pwsh.exe -sshs -nologo

# restart sshd
Restart-Service sshd

# check short name for Program Files
Get-CimInstance Win32_Directory -Filter 'Name="C:\\Program Files"' |
  Select-Object EightDotThreeFileName

```

```bash
# rename the hostname
wmic computersystem where name="%COMPUTERNAME%" call rename name="NEW-NAME"
```
