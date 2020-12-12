
$defaultEnvUrl = "https://gist.githubusercontent.com/rzuquim/3ae05aba3d29572012d4f31f7293e716/raw/c2f0687e683e54c79345f8554c72e72c18779548/.env"

$envUrl = Read-Host -Prompt "Please enter the .env file URL (using default if none)"
if (-not $envUrl) {
  $envUrl = $defaultEnvUrl
}

curl $envUrl -OutFile ~/.env

get-content ~/.env | ForEach-Object {
  if (-not $_ ) { return }

  $split = $_.Split('=', 2)
  $envVarKey = $split[0]
  $envVarValue = $split[1]

  if ((-not $envVarKey) -or (-not $envVarValue)) { return }

  [System.Environment]::SetEnvironmentVariable($envVarKey, $envVarValue, [System.EnvironmentVariableTarget]::Machine)
}
