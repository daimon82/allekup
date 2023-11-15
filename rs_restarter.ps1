$params = @{'server'='ag-etail-sql.ALLEGROGROUP.INTERNAL';'Database'='AX63PROD'}
$ToDoQuery = "Select x.serverid,x.SERVERINSTANCE,x.recid 
    from 
	    (select serverid, SERVERINSTANCE, max(recid) as recid, DateAdd(minute,6,max(DATEOFRESTART)) as maxdateofrestart
	    from rsmonitorview
	    group by serverid,serverinstance) as x
    inner join rsmonitorview as monitor 
	    on monitor.RECID = x.recid and monitor.dateofrequest > x.maxdateofrestart
    where 
	    monitor.DATEOFRESTART  = 0 " #zapytanie pobiera tylko najnowszy requst restartu dla każdego serwera i rs

function Write-LogToTable {
    param (
        $Recid,$Msg
    )
    $date = Get-Date 
    $date = $date.ToUniversalTime()
    $date = $date.tostring("yyyy-MM-dd HH:mm:ss")
    $reportQuery = "update RSMONITORTABLE set restartlog='$msg',dateofrestart='$date' where recid=$Recid"
    Invoke-sqlcmd @params -Query $reportQuery
}

$ToDo = Invoke-sqlcmd @params -Query $ToDoQuery
foreach ($recid in $ToDo.recid) {
    $server   = ($ToDo|Where{$_.recid -eq $recid}).serverid
    $instance = ($ToDo|Where{$_.recid -eq $recid}).serverinstance
    $searchinstance = '*('+ $instance +')'
    $rsservice = get-service -ComputerName $server | where-object {$_.displayname -like 'SQL Server Reporting Services*' -and $_.displayname -like $searchinstance}
    write-host $server $instance $rsservice.count
    
    if ($rsservice.count -eq 0) {
        Write-LogToTable -Recid $Recid -Msg 'Error, RS instance or server not found'
    }
    if ($rsservice.count -gt 1) {
        Write-LogToTable -Recid $Recid -Msg 'Error, more then one RS instance found!'
    }

    if ($rsservice.count -eq 1) {
        $Error.Clear()
        Try {
            $rsservice | stop-service -ErrorAction Stop
            $rsservice | start-service  -ErrorAction Stop
        } Catch {
            Write-LogToTable -Recid $Recid -Msg $error.substring(0,250)
        }
        if ($error.count -eq 0){
            Write-LogToTable -Recid $Recid -Msg 'Service Restarted'
        }
    }
}
