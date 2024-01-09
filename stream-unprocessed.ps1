$Config = Get-Content -Raw "$PSScriptRoot/Config.json5" | ConvertFrom-Json

$Command = @(
    "ytarchive",
    "--trace",
    "--cookies", "`"$($Config.CookiesFilePath)`"",
    "--add-metadata",
    "--no-merge",
    "--write-description",
    "--write-thumbnail",
    "--retry-stream", "60",
    "--threads", "$($Config.MediaConcurrentFragments)",
    "--output", "`"$($Config.OutputBase)/$($Config.YTARCHIVEOutputFormat)`"",
    $(& "$PSScriptRoot/Repair-ArgumentsToString" $args),
    "best"
) -join ' '

Invoke-Expression -Command $Command
# ytarchive has very slightly different output template syntax!