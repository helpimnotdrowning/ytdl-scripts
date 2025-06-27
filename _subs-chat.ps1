$Config = Get-Content -Raw "$PSScriptRoot/Config.json5" | ConvertFrom-Json

if ($Config.NoCookies) {
	$CookieConfig = @('--no-cookies')
} else {
	$CookieConfig = $Config.AlwaysUseCookiesFile ? @('--cookies', $Config.CookiesFilePath) : @('--cookies-from-browser', $Config.CookiesBrowser)
}

$Command = @(
    '--verbose',
    '--format', "b",
    '--skip-download',
    '--force-ipv4',
    '--sleep-requests', $Config.ArchiveDataSleep,
    '--sleep-interval', $Config.ArchiveSleepMin,
    '--max-sleep-interval', $Config.ArchiveSleepMax,
    '--ignore-errors',
    '--no-continue',
    '--no-overwrites',
    '--sub-format', 'ass/vtt/srv3/best',
    '--all-subs',
    '--throttled-rate', '100K',
    '--retries', 'infinite',
    '--concurrent-fragments', $Config.DataConcurrentFragments,
    '--no-part',
    '--output', "$($Config.OutputBase)/$($Config.YTDLPOutputFormat)"
)

yt-dlp @CookieConfig @Command @args *>&1
