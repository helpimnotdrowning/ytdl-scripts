$Config = Get-Content -Raw "$PSScriptRoot/Config.json5" | ConvertFrom-Json

$Command = @(
    'yt-dlp',
    '--format', "bestvideo[vcodec^=avc]+bestaudio[acodec^=mp4a]/bestvideo+bestaudio/best"
    '--force-ipv4',
    '--sleep-requests 1',
    '--sleep-interval 5',
    '--max-sleep-interval 15',
    '--ignore-errors',
    '--no-continue',
    '--no-overwrites',
    '--no-write-info-json'
) + $(If ($Config.AlwaysUseCookiesFile) {
    @('--cookies', "`"$($Config.CookiesFilePath)`"")
    
} Else {
    '--cookies-from-browser', "$($Config.CookiesBrowser)"
    
}) + @(
    '--check-formats',
    '--throttled-rate 100K',
    '--retries infinite',
    '--concurrent-fragments', "$($Config.MediaConcurrentFragments)",
    '--merge-output-format mkv',
    '--remux-video mkv',
    '--embed-chapters',
    '--no-part',
    '--sponsorblock-mark', 'all,-poi_highlight,-filler',
    '--output', "`"$($Config.OutputBase)/$($Config.YTDLPOutputFormat)`"",
    $(& "$PSScriptRoot/Repair-ArgumentsToString" $args),
    "2>&1"
) -join ' '

Invoke-Expression -Command $Command