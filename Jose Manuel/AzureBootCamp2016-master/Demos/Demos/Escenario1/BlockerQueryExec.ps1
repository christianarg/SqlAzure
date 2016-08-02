#Exec queries
Import-Module sqlps -DisableNameChecking -WarningAction SilentlyContinue | Out-Null


$query="

begin tran

select * 
from dbo.LockTable with(holdlock)
where c1=7

waitfor delay '00:00:10'

commit

";
$server="iyg43q8cjy.database.windows.net"
$database="DMVsDemos"
$user="JmJurado"
$password="Nuevos123!"
$i=1
$numExecs=100

while($i -le $numExecs)
{
    Invoke-Sqlcmd -ServerInstance $server -Database $database -Query $query -Username $user -Password $password
    Write-Host "Query executed ($i)"
    $i=$i+1
}