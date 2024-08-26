$Config = Get-Content -Raw "$PSScriptRoot/Config.json5" | ConvertFrom-Json

$Command = @(
    '--format', "b",
    '--verbose',
    '--skip-download',
    '--force-ipv4',
    '--ignore-errors',
    '--no-continue',
    '--no-overwrites' # THIS COMMA IS PURPOSFULLY MISSING!!
	
	$Config.AlwaysUseCookiesFile ? ('--cookies', $Config.CookiesFilePath) : ('--cookies-from-browser', $Config.CookiesBrowser),
	
    '--sub-format', 'ass/vtt/srv3/best',
    '--all-subs',
    '--throttled-rate', '100K',
    '--retries', 'infinite',
    '--concurrent-fragments', $Config.DataConcurrentFragments,
    '--no-part',
    '--output', "$($Config.OutputBase)/$($Config.YTDLPOutputFormat)" # THIS COMMA IS PURPOSFULLY MISSING!!
    $args
)

yt-dlp @Command *>&1