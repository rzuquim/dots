
$defaultEnvUrl = "https://gist.githubusercontent.com/rzuquim/10351b0b2733398ba46cddd230aa5978/raw/dec4b8271653b9bf4cdd9cb443b6f1f7d5ac65c0/.winenv"

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
