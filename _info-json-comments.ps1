$Config = Get-Content -Raw "$PSScriptRoot/Config.json5" | ConvertFrom-Json

$Command = @(
    'yt-dlp',
    '--format', "best",
    '--force-ipv4',
    '--sleep-requests', '.25',
    '--sleep-interval', '5',
    '--max-sleep-interval', '15',
    '--ignore-errors',
    '--no-continue',
    '--no-overwrites',
    '--write-description',
    '--write-info-json',
    '--write-comments'
) + $(If ($Config.AlwaysUseCookiesFile) {
    @('--cookies', "`"$($Config.CookiesFilePath)`"")
    
} Else {
    '--cookies-from-browser', "$($Config.CookiesBrowser)"
    
}) + @(
    '--check-formats',
    '--throttled-rate', '100K'
    '--retries', 'infinite'
    '--retries', 'infinite'
    '--concurrent-fragments', "$($Config.DataConcurrentFragments)",
    '--no-part',
    '--sponsorblock-mark', 'all,-poi_highlight,-filler'
    '--skip-download',
    '--output', "`"$($Config.OutputBase)/$($Config.YTDLPOutputFormat)`"",
    $(& "$PSScriptRoot/Repair-ArgumentsToString" $args),
    "2>&1"
) -join ' '

Invoke-Expression -Command $command