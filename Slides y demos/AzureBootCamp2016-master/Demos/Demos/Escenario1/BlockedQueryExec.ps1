#Exec queries
Import-Module sqlps -DisableNameChecking -WarningAction SilentlyContinue | Out-Null


$query="

begin tran

update dbo.LockTable
set c2=c2*2
where c1=7

commit

";
$server="iyg43q8cjy.database.windows.net"
$database="DMVsDemos"
$user="JmJurado"
$password="Nuevos123!"
$i=1
$numExecs=10

while($i -le $numExecs)
{
    Invoke-Sqlcmd -ServerInstance $server -Database $database -Query $query -Username $user -Password $password
    Write-Host "Query executed ($i)"
    $i=$i+1
}