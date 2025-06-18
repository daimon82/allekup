#$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri https://aka.ms/installazurecliwindowsx64 -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; Remove-Item .\AzureCLI.msi
#Install-Module -name az -scope currentuser -Repository PSGallery -Force
#import-module az
#connect-azaccount
#Update-PSResource Az
#install azure cli manually


$clientId = ""
$clientSecret = ""
$tenantId = ""

#az login --service-principal -u $clientId -p $clientSecret --tenant $tenantId

$securePassword = ConvertTo-SecureString $clientSecret -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($clientId, $securePassword)

Connect-AzAccount -ServicePrincipal -TenantId $tenantId -Credential $credential

$serverName = ""
$databaseName = ""
$tableName = ""
$connectionString = "Server=$serverName;Database=$databaseName;Integrated Security=True;"


$cutoffDate = (get-date).adddaYs(-$retention)

write-host "Resource group: $resourceGroupName retention: $retention days, cut off date: $cutoffDate"
write-host "Listing all blobs from $storageAccountName : " -NoNewline
$ctx = (Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName).Context
#$blobs = Get-AzStorageBlob -Container $containerName -Context $ctx
#write-host $blobs.count


az login --service-principal --username $clientid --password $clientSecret --tenant $tenantid
& "C:\skrypty\azcopy.exe" list "https://aled365dlsa.blob.core.windows.net/dataverse-alewhs-unq9c0220b0cb9044f396203bc9ad3a5/?sv=2024-11-04&ss=b&srt=c&sp=rwdlacyx&se=2025-12-31T08:16:39Z&st=2025-06-15T23:16:39Z&spr=https&sig=ibVjxBgN%2BS%2FXYKnYpm%2B9%2B9eOECiSlxApJHr6SLo%2B4FY%3D" > c:\skrypty\blobs.txt
Get-Content "c:\skrypty\blobs.txt" | ForEach-Object {
    $parts = $_ -split ';'
    $parts[0]
} | Out-File "c:\skrypty\blobs_only.txt" -Encoding utf8

Copy-Item -Path "C:\skrypty\blobs_only.txt" -Destination "\\s44556\skrypty\blobs_only.txt"

Add-Type -AssemblyName System.Data

# Connect to SQL Server
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString
$connection.Open()

 $command = $connection.CreateCommand()

$query = "truncate table sc_temp;
	BULK INSERT sc_temp
	FROM 'C:\skrypty\blobs_only.txt'
	WITH (
		FIELDTERMINATOR = ';',
		ROWTERMINATOR = '\n')"

$command.CommandText = $query
$command.ExecuteNonQuery()

$query = "truncate table [$tableName];
	INSERT INTO [$tableName]  (bname,broot,bdate,isathena)
	select 
		bname,
		left(bname,20) as broot,
		cast(replace(left(bname,20),'.',':') as datetime2) as bdate,
		CASE WHEN bname LIKE '%Athena%' THEN 1 ELSE 0 END as isAthena
	from sc_temp 
	 where ISNUMERIC(LEFT(bname, 4)) = 1"
$command.CommandText = $query
$command.ExecuteNonQuery()

$connection.Close()