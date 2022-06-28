
$sqlServerFQDN = $env:SERVERNAME

$databaseName = $env:DATABASENAME



$userQuery = "
  declare @results varchar(max)

  select @results = coalesce(@results + ',', '') +  [redirectUrl]
  from [dbo].[serviceRedirectUris]
  order by [redirectUrl]

  select @results as results
"


$results = Invoke-Sqlcmd -ServerInstance $sqlServerFQDN -Database $databaseName -Username '__auditSqlLogin__' -Password '__auditSqlPassword__'  -query $userQuery  -Verbose 
$results = $results -replace '"',''
Write-Host "##vso[task.setvariable variable=redirectUrls]$results"

Write-Output $redirectUrls
