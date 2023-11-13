$secret =  get-content dra_update_secret.json | ConvertFrom-Json

$ServiceName = $secret.ServiceName
$UserName = $secret.UserName
$Password = $secret.Password

$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($UserName,$SecurePassword)

#$MyApp = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq "Microsoft Dynamics 365 for Finance and Operations: Document Routing"}
#$MyApp.Uninstall()
$uninststring = (Get-ChildItem -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall", "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | Get-ItemProperty | Where-Object { $_.DisplayName -match "Microsoft Dynamics 365 for Finance and Operations: Document Routing" } | Select-Object UninstallString).uninstallString
$cmd = $uninststring.Replace("MsiExec.exe ",'')
$cmd = "/quiet "+ $cmd

Start-Process MsiExec.exe -wait -ArgumentList $cmd

start-sleep 5
Start-Process msiexec.exe -Wait -ArgumentList '/I C:\Users\_dax_print_svc\Desktop\DocumentRoutingAgentSetup.msi /quiet'
start-sleep 10
Stop-Service -Name $servicename
Set-Service -Name $ServiceName -Credential $Credential
Start-Service -Name $servicename