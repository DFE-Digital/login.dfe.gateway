
$sqlServerFQDN = $env:SERVERNAME

$databaseName = $env:DATABASENAME

$user = '__auditSqlLogin__'
$pass = '__auditSqlPassword__'

$userQuery = "
  declare @results varchar(max)

  select @results = coalesce(@results + ',', '') +  [redirectUrl]
  from [dbo].[serviceRedirectUris]
  order by [redirectUrl]

  select @results as results
"

Write-Output $user $pass 'hi'

$results = Invoke-Sqlcmd -ServerInstance $sqlServerFQDN -Database $databaseName -Username $user -Password $pass  -query $userQuery  -Verbose 
$results = $results -replace '"',''
Write-Host "##vso[task.setvariable variable=redirectUrls;isoutput=ture]$results"

Write-Output $redirectUrls
