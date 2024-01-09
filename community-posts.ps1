$Config = Get-Content -Raw "$PSScriptRoot/Config.json5" | ConvertFrom-Json

$Command = @(
    "~/youtube-community-tab/ytct.py",
    "--cookies", "`"$($Config.CookiesFilePath)`"",
    "--dates",
    $(& "$PSScriptRoot/Repair-ArgumentsToString" $args)
) -join ' '

Invoke-Expression -Command $Command

# TODO: Conditionally include --cookies flag depending on if cookies file exists.