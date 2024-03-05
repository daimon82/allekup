[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')

#################################################### GUI XAML CONFIG ####################################################
$input = @'
<Window x:Class="ps_opsgenie.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:ps_opsgenie"
        mc:Ignorable="d"
        Title="OpsGenie Genie" Height="525" Width="719">
    <Grid>
        <TabControl x:Name="MainTabControl">
            <TabItem x:Name="SetTab" Header="Set New">
                <Grid Background="#FFE5E5E5">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="42*"/>
                        <ColumnDefinition Width="64*"/>
                        <ColumnDefinition Width="607*"/>
                    </Grid.ColumnDefinitions>
                    <GroupBox Header="Maintenance Start " Margin="0,17,367,0" HorizontalAlignment="Right" Width="220" Grid.Column="2" Height="235" VerticalAlignment="Top">
                        <Grid Height="230">
                            <Calendar x:Name="CalendarFrom" HorizontalAlignment="Center" Margin="0,2,0,0" VerticalAlignment="Top"/>
                            <ComboBox x:Name="ComboFromH" HorizontalAlignment="Left" Margin="15,180,0,0" VerticalAlignment="Top" Width="89">
                                <ComboBoxItem Content="HH" IsSelected="True" IsEnabled="False"/>
                                <ComboBoxItem Content="0"/>
                                <ComboBoxItem Content="1"/>
                                <ComboBoxItem Content="2"/>
                                <ComboBoxItem Content="3"/>
                                <ComboBoxItem Content="4"/>
                                <ComboBoxItem Content="5"/>
                                <ComboBoxItem Content="6"/>
                                <ComboBoxItem Content="7"/>
                                <ComboBoxItem Content="8"/>
                                <ComboBoxItem Content="9"/>
                                <ComboBoxItem Content="10"/>
                                <ComboBoxItem Content="11"/>
                                <ComboBoxItem Content="12"/>
                                <ComboBoxItem Content="13"/>
                                <ComboBoxItem Content="14"/>
                                <ComboBoxItem Content="15"/>
                                <ComboBoxItem Content="16"/>
                                <ComboBoxItem Content="17"/>
                                <ComboBoxItem Content="18"/>
                                <ComboBoxItem Content="19"/>
                                <ComboBoxItem Content="20"/>
                                <ComboBoxItem Content="21"/>
                                <ComboBoxItem Content="22"/>
                                <ComboBoxItem Content="23"/>
                            </ComboBox>
                            <ComboBox x:Name="ComboFromM" HorizontalAlignment="Left" Margin="109,180,0,0" VerticalAlignment="Top" Width="85">
                                <ComboBoxItem Content="MM" IsSelected="True" IsEnabled="False"/>
                                <ComboBoxItem Content="00"/>
                                <ComboBoxItem Content="15"/>
                                <ComboBoxItem Content="30"/>
                                <ComboBoxItem Content="45"/>
                            </ComboBox>
                        </Grid>
                    </GroupBox>
                    <GroupBox Header="Maintenance End" Margin="0,17,123,0" HorizontalAlignment="Right" Width="220" Grid.Column="2" Height="235" VerticalAlignment="Top">
                        <Grid>
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="75*"/>
                                <ColumnDefinition Width="133*"/>
                            </Grid.ColumnDefinitions>
                            <Calendar x:Name="CalendarTo" HorizontalAlignment="Left" Margin="14,2,0,0" VerticalAlignment="Top" Grid.ColumnSpan="2"/>
                            <ComboBox x:Name="ComboToH" HorizontalAlignment="Left" Margin="15,180,0,0" VerticalAlignment="Top" Width="89" Grid.ColumnSpan="2">
                                <ComboBoxItem Content="HH" IsSelected="True" IsEnabled="False"/>
                                <ComboBoxItem Content="0"/>
                                <ComboBoxItem Content="1"/>
                                <ComboBoxItem Content="2"/>
                                <ComboBoxItem Content="3"/>
                                <ComboBoxItem Content="4"/>
                                <ComboBoxItem Content="5"/>
                                <ComboBoxItem Content="6"/>
                                <ComboBoxItem Content="7"/>
                                <ComboBoxItem Content="8"/>
                                <ComboBoxItem Content="9"/>
                                <ComboBoxItem Content="10"/>
                                <ComboBoxItem Content="11"/>
                                <ComboBoxItem Content="12"/>
                                <ComboBoxItem Content="13"/>
                                <ComboBoxItem Content="14"/>
                                <ComboBoxItem Content="15"/>
                                <ComboBoxItem Content="16"/>
                                <ComboBoxItem Content="17"/>
                                <ComboBoxItem Content="18"/>
                                <ComboBoxItem Content="19"/>
                                <ComboBoxItem Content="20"/>
                                <ComboBoxItem Content="21"/>
                                <ComboBoxItem Content="22"/>
                                <ComboBoxItem Content="23"/>
                            </ComboBox>
                            <ComboBox x:Name="ComboToM" HorizontalAlignment="Left" Margin="34,180,0,0" VerticalAlignment="Top" Width="85" Grid.Column="1">
                                <ComboBoxItem Content="MM" IsSelected="True" IsEnabled="False"/>
                                <ComboBoxItem Content="00"/>
                                <ComboBoxItem Content="15"/>
                                <ComboBoxItem Content="30"/>
                                <ComboBoxItem Content="45"/>
                            </ComboBox>
                        </Grid>
                    </GroupBox>
                    <ListView x:Name="ListViewTeams" Grid.Column="1" Margin="0,277,233,10" Grid.ColumnSpan="2">
                        <ListView.View>
                            <GridView>
                                <GridViewColumn Header="Team Name" DisplayMemberBinding="{Binding TeamName}"/>
                                <GridViewColumn Header="Api OK"    DisplayMemberBinding="{Binding ApiOK}"/>
                                <GridViewColumn Header="Policy OK" DisplayMemberBinding="{Binding PolicyOK}"/>
                            </GridView>
                        </ListView.View>
                    </ListView>
                    <Button x:Name="ButtonLoadTeam" Grid.Column="2" Content="Load Teams" Margin="0,278,63,0" HorizontalAlignment="Right" Width="136" Height="20" VerticalAlignment="Top"/>
                    <Button x:Name="ButtonSetMain" Grid.Column="2" Content="Create Window" Margin="0,0,63,10" HorizontalAlignment="Right" Width="136" Height="20" VerticalAlignment="Bottom"/>
                    <TextBox x:Name="TextBoxDesc" Grid.Column="2" Margin="0,0,63,52" TextWrapping="Wrap" Text="Maint. Description" Height="18" VerticalAlignment="Bottom" HorizontalAlignment="Right" Width="136"/>
                    <Button x:Name="DarkModeButtonTab1" Content="(Ͼ˳Ͽ)" HorizontalAlignment="Right" VerticalAlignment="Bottom" Margin="0,0,5,5" Grid.Column="3" />
                </Grid>
            </TabItem>
            <TabItem x:Name="DeleteTab" Header="List and Delete">
               <Grid Background="#FFE5E5E5">
                   <ListView x:Name="ListViewWindowGroup" Margin="0,0,0,122">
                       <ListView.View>
                           <GridView>
                               <GridViewColumn Header="Team Name" DisplayMemberBinding="{Binding TeamName}"  />
                               <GridViewColumn Header="Status" DisplayMemberBinding="{Binding Status}"  />
                               <GridViewColumn Header="Desc" DisplayMemberBinding="{Binding Desc}"  />
                               <GridViewColumn Header="Start" DisplayMemberBinding="{Binding Start}"  />
                               <GridViewColumn Header="End" DisplayMemberBinding="{Binding End}"  />
                               <GridViewColumn Header="WindowID" DisplayMemberBinding="{Binding WindowID}" Width="0" />
                           </GridView>
                       </ListView.View>
                   </ListView>
                   <ListView x:Name="ListViewWindowDetail" Margin="0,0,0,122" Visibility="Hidden">
                       <ListView.View>
                           <GridView>
                               <GridViewColumn Header="Team Name" DisplayMemberBinding="{Binding TeamName}"  />
                               <GridViewColumn Header="Status" DisplayMemberBinding="{Binding Status}"  />
                               <GridViewColumn Header="Desc" DisplayMemberBinding="{Binding Desc}"  />
                               <GridViewColumn Header="Start" DisplayMemberBinding="{Binding Start}"  />
                               <GridViewColumn Header="End" DisplayMemberBinding="{Binding End}"  />
                               <GridViewColumn Header="WindowID" DisplayMemberBinding="{Binding WindowID}" Width="0" />
                           </GridView>
                       </ListView.View>
                   </ListView>
                   <CheckBox x:Name="CheckBoxShowDetails" Content="Show detaild view" HorizontalAlignment="Left" Margin="29,0,0,84" Height="15" VerticalAlignment="Bottom" Width="167"/>
                   <Button x:Name="ButtonLoadMainWindows" Content="Load Maint. Windows" HorizontalAlignment="Left" Margin="29,0,0,38" VerticalAlignment="Bottom" RenderTransformOrigin="0.523,-0.272" Width="124"/>
                   <Button x:Name="ButtonDeleteWindows" Content="Delete" HorizontalAlignment="Center" Margin="0,0,0,38" VerticalAlignment="Bottom" RenderTransformOrigin="0.523,-0.272" Width="124"/>
                   <Button x:Name="DarkModeButtonTab2" Content="(Ͼ˳Ͽ)" HorizontalAlignment="Right" VerticalAlignment="Bottom" Margin="0,0,5,5" Grid.Column="3" />
               </Grid>
           </TabItem>
        </TabControl>
    </Grid>
</Window>
'@

#################################################### CONFIG ####################################################

$input = $input -replace '^<Window.*', '<Window' -replace 'mc:Ignorable="d"','' -replace "x:N",'N' 
[xml]$xaml = $input
$xmlreader=(New-Object System.Xml.XmlNodeReader $xaml)
$xamlForm=[Windows.Markup.XamlReader]::Load( $xmlreader )

$xaml.SelectNodes("//*[@Name]") | ForEach-Object -Process {
    Set-Variable -Name ($_.Name) -Value $xamlForm.FindName($_.Name)
    }

$ButtonLoadTeam.add_click({ f_ButtonClick_LoadTeams })
$ButtonSetMain.add_click({ f_ButtonClick_SetMaintenance })
$ButtonLoadMainWindows.add_click({ f_ButtonClick_LoadMaintenance })
$ButtonDeleteWindows.add_click({ f_ButtonClick_DeleteMaint })

$CheckBoxShowDetails.Add_Checked(  { f_ShowDetails })
$CheckBoxShowDetails.Add_UnChecked({ f_ShowDetails })

# Read API keys and calendar names form the network - access restricted to ad group: _gr_opsgenie_api
$jsonFilePath = "\\allegrogroup.internal\EtailArchiwum\AdminDocs\og_api.json"
try {
    # Read the content of the JSON file
    $jsonContent = Get-Content -Path $jsonFilePath -Raw -ErrorAction stop
    $ApiKeyTeamMapping = $jsonContent | ConvertFrom-Json
} catch {
    [System.Windows.Forms.MessageBox]::Show("You don't have access to opsGenie API  $_.Exception.Message", "Can't access configuration", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
    break
}

# Array to store team schedule objects
$global:TeamList = @()
$global:WindowList = @()
$global:GroupWindowList = @()

#################################################### BUTTON FUNCTIONS ####################################################

function f_ButtonClick_LoadTeams {
    $buttonLoadTeam.IsEnabled = $false
    $buttonSetMain.IsEnabled = $false;

    write-host 'Listing Team details, and maintenance plan availibility for each team'
    $global:TeamList = @()

    foreach ($team in $ApiKeyTeamMapping) {
        Get-OpsGenieTeam -apiKey $team.apiKey -ScheduleName $team.ScheduleName
    }

   
    #Quick Debug
    $global:TeamList |select TeamName,NotifyPolicyName,TeamId,NotifyPolicyId,ApiOk,PolicyOK| Format-Table | Out-String|% {Write-Host $_}

    # Add teams to the ListView
    $ListViewTeams.Items.Clear()
    foreach ($team in $global:TeamList) {
        $NewItem = New-Object PSObject -Property @{
            TeamName = $Team.TeamName
            ApiOK = $Team.ApiOK
            PolicyOK = $Team.PolicyOK
        }
        [void]$ListViewTeams.Items.Add($NewItem)
    }
    #$ListViewTeams.AutoResizeColumns(2) #Resize based on content
    $buttonLoadTeam.IsEnabled = $true;
    $buttonSetMain.IsEnabled = $true;
    write-host "`nOpsGenie Teams Load Completed!"
}

function f_ButtonClick_SetMaintenance {
    #Check and construct Start Date/Time 
    $CalStartDate = $CalendarFrom.SelectedDate
    $StartHour = $ComboFromH.SelectedItem.Content
    $StartMinute = $ComboFromM.SelectedItem.Content
    
    if ($CalStartDate -and $StartHour -and $StartMinute){
        $startDate = $calStartDate.AddHours([int]$StartHour).AddMinutes([int]$StartMinute)
    } else {
        [System.Windows.Forms.MessageBox]::Show("Pick a Start date hour and minutes", "Bad Start date/time", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
        return
    }

    #Check and construct End Date/Time 
    $CalEndDate = $CalendarTo.SelectedDate
    $EndHour = $ComboToH.SelectedItem.Content
    $EndMinute = $ComboToM.SelectedItem.Content
    
    if ($CalEndDate -and $EndHour -and $EndMinute){
        $EndDate = $calEndDate.AddHours([int]$EndHour).AddMinutes([int]$EndMinute)
    } else {
        [System.Windows.Forms.MessageBox]::Show("Pick a End date hour and minutes", "Bad Start date/time", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
        return
    }
    
    $selectedTeams = $ListViewTeams.SelectedItems
        
    $desc = $TextBoxDesc.Text
    
    if ($selectedTeams.count -eq 0){
        [System.Windows.Forms.MessageBox]::Show("Please select at least one item.", "No Items Selected", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
        return
    }
    if ($endDate -le $startDate){
        [System.Windows.Forms.MessageBox]::Show("Start or End date time is wrong.", "Bad date/time", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
        return
     }

    # Are you sure?!
    $msg = "Start: $startDate`nEnd:   $endDate`n`nTeams:`n"
    foreach ($team in $selectedTeams) {
        $msg += "$($team.TeamName)`n"
    }
    $msg += "Desc: $desc`n"
    $msg += "`nSet a new Maintenance window?"

    $confirmation = [System.Windows.MessageBox]::Show($msg, "Are you sure?", "YesNo", "Question")
    if ($confirmation -eq "No") {
        return
    }

    write-host "Setting up maintenance windows:"
    foreach ($team in $selectedTeams) {
        $teamDetails = $global:TeamList | Where-Object { $_.TeamName -eq $($team.TeamName) }
        $apikey2set = $teamDetails.apikey
        $NotifyPolicyId2set = $teamDetails.NotifyPolicyId

        write-host "$($team.TeamName) Start: $startDate End: $endDate"
        Set-OpsGenieMaintenanceWindow -ApiKey $apikey2set -NotifyPolicyId $NotifyPolicyId2set -StartDateTime $startDate -EndDateTime $endDate -Desc $desc
    }
    write-host "`nOpsGenie Set Maintenance Window Completed!"
}

function f_ButtonClick_LoadMaintenance {
    $ButtonLoadMainWindows.IsEnabled = $false
    $ButtonDeleteWindows.IsEnabled = $false

    write-host "Loading Maintenance Windows"

    if ($global:TeamList.Count -eq 0){
        write-host "Team Config not found - generating now"
        f_ButtonClick_LoadTeams
    }
    if ($global:TeamList.Count -eq 0){
        write-host 'Blad wczytywania listy teamow'
        return
    }
    
    $ListViewWindowDetail.Items.Clear()
    $ListViewWindowGroup.Items.Clear()
    $global:WindowList = @()
    $global:GroupWindowList = @()

    foreach($team in $global:TeamList){
        Get-MaintWindows -apiKey $team.ApiKey -TeamName $team.TeamName
    }

    #Quick Debug
    $global:WindowList |select TeamName,Desc,Start,End,type,status,WindowId| Format-Table | Out-String|% {Write-Host $_}

    foreach ($window in $global:WindowList) {
        $newItem = New-Object PSObject -Property @{
            TeamName = $window.TeamName    
            Status = $window.Status
            Desc = $window.Desc
            Start = $window.Start
            End = $window.End
            WindowID = $window.WindowId
        }
        [void]$ListViewWindowDetail.Items.Add($newItem)
    }

    foreach ($window in $global:GroupWindowList) {
        $newItem = New-Object PSObject -Property @{
            TeamName = $window.TeamName    
            Status = $window.Status
            Desc = $window.Desc
            Start = $window.Start
            End = $window.End
            WindowID = $window.WindowId
        }
        [void]$ListViewWindowGroup.Items.Add($newItem)
    }

    $ButtonLoadMainWindows.IsEnabled = $true;
    $ButtonDeleteWindows.IsEnabled = $true;
    write-host "`nOpsGenie Load Maintenance Window Completed!"
}

function f_ButtonClick_DeleteMaint {
    $selectedTeamsDetails = $ListViewWindowDetail.SelectedItems
    $selectedTeamsGroups = $ListViewWindowGroup.SelectedItems
  
    if ($selectedTeamsDetails.count -eq 0 -and $selectedTeamsGroups.count -eq 0){
        [System.Windows.Forms.MessageBox]::Show("Please select at least one item.", "No Items Selected", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
        return
    }
    
    # Are you sure?!
    $msg = "You are about to`nDELETE $($selectedTeamsDetails.count + $selectedTeamsGroups.count) windows`nAre you sure?"
    $confirmation = [System.Windows.MessageBox]::Show($msg, "Are you sure?", "YesNo", "Question")
    if ($confirmation -eq "No") {
        return
    }

    write-host "Deleting:"

    #Deleting
    foreach($item in $selectedTeamsDetails){
        $windowID = $item.WindowID
        $apikey = $global:WindowList | where{$_.WindowId -eq $windowid}
        $apiKey = $apiKey.apiKey
        write-host "$apiKey $WindowId"
        delete-MaintWindow -apiKey $apiKey -WindowID $WindowId
    }
    foreach($group in $selectedTeamsGroups){
        $idArr = $group.WindowID -split ';'
        foreach($windowID in $idArr){
            $apikey = $global:WindowList | where{$_.WindowId -eq $windowid}
            $apiKey = $apiKey.apiKey
            write-host "$apiKey $WindowId"
            delete-MaintWindow -apiKey $apiKey -WindowID $WindowId
        }
    }
    #Load Maintenance windows again.
    f_ButtonClick_LoadMaintenance
    write-host "`nOpsGenie Delete Maintenance Window Completed!"
}

function f_ShowDetails {
    if ($CheckBoxShowDetails.IsChecked) {
        # Clone width of columns
        for ($i = 0; $i -lt $ListViewWindowGroup.View.Columns.Count; $i++) {
            $sourceColumn = $ListViewWindowGroup.View.Columns[$i]
            $targetColumn = $ListViewWindowDetail.View.Columns[$i]
            $targetColumn.Width = $sourceColumn.ActualWidth
        }
        $ListViewWindowGroup.Visibility = "Hidden"
        $ListViewWindowDetail.Visibility = "Visible"

    } else {
        $ListViewWindowDetail.Visibility = "Hidden"
        $ListViewWindowGroup.Visibility = "Visible"
    }
    $ListViewWindowDetail.SelectedItems.Clear()
    $ListViewWindowGroup.SelectedItems.Clear()
}

#################################################### API CALLS ####################################################

function Get-OpsGenieTeam {
    param (
        [string]$apiKey,
        [string]$ScheduleName
    )
    write-host $ScheduleName

   $apiUrl = "https://api.opsgenie.com/v2/schedules/$($ScheduleName)?identifierType=name"
   $headers = @{
        'Authorization' = "GenieKey $apiKey"
   }
   $responseSchedules = Invoke-RestMethod -Uri $apiUrl -Method Get -Headers $headers
   write-host $responseSchedules

   # Check response status
   if ($responseSchedules.data.id) {
       $apiUrl = "https://api.opsgenie.com/v2/policies/notification?teamId=$($responseSchedules.data.ownerTeam.id)"
        $responsePolicies = Invoke-RestMethod -Uri $apiUrl -Method Get -Headers $headers
        write-host "$responsePolicies`n"
    } else {
        Write-Host "Error retrieving schedules for team : $($responseSchedules.message)"
        return $null
    }
    
    #Constructing main information table about OpsGenie environment
    $teamObject = [PSCustomObject]@{
           'TeamName' = $responseSchedules.data.ownerTeam.name
           'ScheduleName' = $ScheduleName
           'NotifyPolicyName' = ''
           'ApiKey' = $apiKey
           'TeamId' = $responseSchedules.data.ownerTeam.id
           'ScheduleId' = $responseSchedules.data.id
           'NotifyPolicyId'   = ''
           'ApiOK' = 'no'
           'PolicyOK' = 'no'
       }

    foreach ($policy in $responsePolicies.data){
        if ($policy.name -eq 'Maintenance_Mode_Policy') {
            $teamObject.NotifyPolicyName = $responsePolicies.data.name
            $teamObject.NotifyPolicyId   = $responsePolicies.data.id
        }
    }

    if ($responseSchedules.data.ownerTeam.id) {$teamObject.ApiOk = 'ok'}
    if ($responsePolicies.data.id) {$teamObject.PolicyOK = 'ok'}

    $global:TeamList += $teamObject
}

function Set-OpsGenieMaintenanceWindow {
    param (
        [string]$ApiKey,
        [string]$NotifyPolicyId,
        [DateTime]$StartDateTime,
        [DateTime]$EndDateTime,
        [string]$desc
    )

    $Headers = @{
        "Authorization" = "GenieKey $ApiKey"
        "Content-Type" = "application/json"
    }
    $FormattedStartTime = $StartDateTime.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
    $FormattedEndTime = $EndDateTime.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

# Payload for creating the maintenance policy
    $body = @{
        "description" = $desc
        time = @{
            "type" = "schedule"
            "startDate" = $FormattedStartTime
            "endDate" = $FormattedEndTime
        }
        "rules" = @(
            @{
                "state" = "enabled"
                "entity" = @{
                    "id" = $NotifyPolicyId
                    "type" = "policy"
                }
            }
        )
    } | ConvertTo-Json -Depth 10

        $Response = Invoke-RestMethod -Uri 'https://api.opsgenie.com/v1/maintenance' -Method Post -Headers $Headers -Body $Body -ErrorAction Stop
        Write-host $Response
}

function Get-MaintWindows {
    param (
        [string]$apiKey,
        [string]$TeamName
    )

   $apiUrl = "https://api.opsgenie.com/v1/maintenance"
   $headers = @{
        'Authorization' = "GenieKey $apiKey"
   }
   $responseWindows = Invoke-RestMethod -Uri $apiUrl -Method Get -Headers $headers

   write-host $TeamName
   write-host $responseWindows

   # Check response status
   if ($responseWindows.data.count -eq 0) {
        Write-Host "$TeamName - No Maintenance Windows"
        return $null
    }

    foreach ($window in $responseWindows.data){
        if ($window.status -in @('cancelled','past')) {
            continue
        }
        write-host $window

        #Checking for schedule type: for-5-minutes, for-30-minutes, for-1-hour, indefinitely or schedule
        $starttime = add-toOGTime -stringTime $window.time.startDate
        $endtime = ''
        if ($window.time.type -eq 'schedule')     {
            $endtime = add-toOGTime -stringTime $window.time.endDate}
        if ($window.time.type -eq 'for-5-minutes'){
            $endtime = add-toOGTime -stringTime $window.time.startDate -timeunit 'minute' -amount 5}
        if ($window.time.type -eq 'for-30-minutes'){
            $endtime = add-toOGTime -stringTime $window.time.startDate -timeunit 'minute' -amount 30}
        if ($window.time.type -eq 'for-1-hour'){
            $endtime = add-toOGTime -stringTime $window.time.startDate -timeunit 'hour' -amount 1}
        if ($window.time.type -eq 'indefinitely'){
            $endtime = 'indefinitely'}

        $windowObject = [PSCustomObject]@{
               'TeamName' = $TeamName
               'apiKey' = $apiKey
               'Desc' = $window.description
               'WindowId' = $window.id
               'Start' = $starttime
               'End' = $endtime
               'type' = $window.time.type
               'status' = $window.status
        }
        $global:WindowList += $windowObject 


        #Grouping windwos based on start and stop dates
        #Searching for index of existing window in $global:WindowListGroup
        $windowObjectClone = $windowObject.PSObject.Copy()
        $index = -1
        for ($i = 0; $i -lt $($global:GroupWindowList.Count); $i++) {
            if ($global:GroupWindowList[$i].Start -eq $starttime -and $global:GroupWindowList[$i].End -eq $endtime) {
                $index = $i
                break
            }
        }
        
        if ($index -ge 0) {
            $toChange = $global:GroupWindowList[$index]
            $toChange.TeamName += "; $TeamName"
            $toChange.WindowId += ";$($window.id)"
        } else {
            $global:GroupWindowList += $windowObjectClone
        }
    }
}

function add-toOGTime{
    param(
        [string]$stringTime,
        [string]$timeunit = '',
        [int]$amount = 0
    )

    $time = [DateTime]::ParseExact($stringTime, "yyyy-MM-ddTHH:mm:ssZ", [System.Globalization.CultureInfo]::InvariantCulture)
    $time = $time.ToLocalTime()

    if ($timeunit -eq 'minute'){
        $time = $time.AddMinutes($amount)
    }
    if ($timeunit -eq 'hour'){
        $time = $time.Addhours($amount)
    }
    $returnvalue = $time.ToString("yyyy-MM-dd HH:mm")
    return $returnvalue
}

function delete-MaintWindow{
    param (
        [string]$apiKey,
        [string]$WindowId
    )

    $apiUrl = "https://api.opsgenie.com/v1/maintenance/$WindowId"
    $headers = @{
        'Authorization' = "GenieKey $apiKey"
   }
   $responseSchedules = Invoke-RestMethod -Uri $apiUrl -Method DELETE -Headers $headers
   write-host $responseSchedules
}

#################################################### INIT ####################################################
$xamlForm.ShowDialog() | out-null