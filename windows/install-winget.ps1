param(
  [string]$Input = "$PSScriptRoot\winget-packages.json"
)

if (!(Test-Path "$Input")) {
  Write-Error "Missing $Input"
  exit 1
}

winget source update | Out-Null
winget import -i "$Input" --ignore-versions --accept-package-agreements --accept-source-agreements
