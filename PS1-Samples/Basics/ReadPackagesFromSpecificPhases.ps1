## Module RayFlow is required, see readme.md for more details

## Replace with your values
$url = 'https://<rayflow-server-url>:<port>/<instance>';
$projectName = '<your-project-name>';

## If you do not want to enter plain text password here, you can skip creation of credentials object and call the subsequent commands
## without credentials. You will be asked interactively to provide them.
$userName = '<your-user-name>';
$password = '<your-password>';
$cred = Get-RayFlowCredentials -UserName $userName -PlainTextPassword $password;

$project = Get-RayFlowProject -RayFlowServerUrl $url -Credentials $cred -ProjectName $projectName;
$allPhases = Get-RayFlowPhase -Project $project

## The following cherry-picks PKG and EVAL phases by comparing their short names
$selectedPhases = $allPhases | Where-Object { ($_.ShortName -eq 'PKG') -or ($_.ShortName -eq 'EVAL') }

foreach ($phase in $selectedPhases) {
    Write-Progress -Activity ("Getting tasks from " + $phase.ShortName);
    $tasks = Get-RayFlowTask -Phase $phase

    Write-Output "### Phase: $phase `r`n";
    Write-Output ($tasks | Select-Object Id, ApplicationId, ApplicationVendor, ApplicationName, ApplicationVersion, ApplicationLanguage | Format-Table -AutoSize | Out-String);
}