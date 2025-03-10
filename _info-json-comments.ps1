$Config = Get-Content -Raw "$PSScriptRoot/Config.json5" | ConvertFrom-Json

$CookieConfig = $Config.AlwaysUseCookiesFile ? @('--cookies', $Config.CookiesFilePath) : @('--cookies-from-browser', $Config.CookiesBrowser)

$Command = @(
	'--verbose',
    '--format', "b",
    '--force-ipv4',
    '--sleep-requests', '.25',
    '--sleep-interval', '5',
    '--max-sleep-interval', '15',
    '--ignore-errors',
    '--no-continue',
    '--no-overwrites',
    '--write-description',
    '--write-info-json',
    '--write-comments',
    '--write-thumbnail',
    '--check-formats',
    '--throttled-rate', '100K',
    '--retries', 'infinite',
    '--concurrent-fragments', $Config.DataConcurrentFragments,
    '--no-part',
    '--sponsorblock-mark', 'all,-poi_highlight,-filler',
    '--skip-download',
    '--output', "$($Config.OutputBase)/$($Config.YTDLPOutputFormat)"
)

yt-dlp @CookieConfig @Command @args *>&1
