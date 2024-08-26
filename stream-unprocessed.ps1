$Config = Get-Content -Raw "$PSScriptRoot/Config.json5" | ConvertFrom-Json

Write-Warning "Dumping browser cookies to $($Config.CookiesFilePath), ignore the upcoming error message from yt-dlp..."
yt-dlp --cookies-from-browser $Config.CookiesBrowser --cookies $Config.CookiesFilePath

sleep 1

$CommandArgs = @(
#    "--trace",
    "--cookies", $Config.CookiesFilePath,
    "--add-metadata",
    "--no-merge",
    "--write-description",
    "--write-thumbnail",
    "--wait",
    "--retry-stream", "60",
    "--threads", $Config.MediaConcurrentFragments,
    "--output", "$($Config.OutputBase)/$($Config.YTARCHIVEOutputFormat)" # THIS COMMA IS PURPOSFULLY MISSING!!
    $args,
    "best"
)

ytarchive @CommandArgs

Remove-Item $Config.CookiesFilePath
