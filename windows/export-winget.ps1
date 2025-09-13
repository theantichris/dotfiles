param(
  [string]$Output = "$PSScriptRoot\winget-packages.json"
)

winget source update | Out-Null
winget export --source winget --output "$Output" --accept-source-agreements
Write-Host "Exported to $Output"
