$Config = Get-Content -Raw "$PSScriptRoot/Config.json5" | ConvertFrom-Json

$CookieConfig = $Config.AlwaysUseCookiesFile ? @('--cookies', $Config.CookiesFilePath) : @('--cookies-from-browser', $Config.CookiesBrowser)

$Command = @(
    '--verbose',
    '--format', "bestvideo[vcodec^=avc]+bestaudio[acodec^=mp4a]/bestvideo+bestaudio/best",
    '--force-ipv4',
    '--sleep-requests', '1',
    '--sleep-interval', '5',
    '--max-sleep-interval', '15',
    '--ignore-errors',
    '--no-continue',
    '--no-overwrites',
    '--no-write-info-json',
    '--check-formats',
    '--throttled-rate', '100K',
    '--retries', 'infinite',
    '--concurrent-fragments', $Config.MediaConcurrentFragments,
    '--merge-output-format', 'mkv',
    '--remux-video', 'mkv',
    '--embed-chapters',
    '--no-part',
    '--sponsorblock-mark', 'all,-poi_highlight,-filler',
    '--output', "$($Config.OutputBase)/$($Config.YTDLPOutputFormat)"
)

yt-dlp @CookieConfig @Command @args *>&1
