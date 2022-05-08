
$defaultEnvUrl = "https://gist.githubusercontent.com/rzuquim/3ae05aba3d29572012d4f31f7293e716/raw/02d02674b3aa524111801595a989be7243038057/.env"

$envUrl = Read-Host -Prompt "Please enter the .env file URL (using default if none)"
if (-not $envUrl) {
  $envUrl = $defaultEnvUrl
}

curl $envUrl -Headers @{"Cache-Control" = "no-cache"} -OutFile ~/.env

get-content ~/.env | ForEach-Object {
  if (-not $_ ) { return }

  $split = $_.Split('=', 2)
  $envVarKey = $split[0]
  $envVarValue = $split[1]

  if ((-not $envVarKey) -or (-not $envVarValue)) { return }

  [System.Environment]::SetEnvironmentVariable($envVarKey, $envVarValue, [System.EnvironmentVariableTarget]::Machine)
}
