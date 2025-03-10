$Config = Get-Content -Raw "$PSScriptRoot/Config.json5" | ConvertFrom-Json

$CookieConfig = $Config.AlwaysUseCookiesFile ? @('--cookies', $Config.CookiesFilePath) : @('--cookies-from-browser', $Config.CookiesBrowser)

$Command = @(
	'--verbose',
	'--format', "bestvideo[vcodec^=avc]+bestaudio[acodec^=mp4a]/bestvideo+bestaudio/best",
	'--force-ipv4',
	'--sleep-interval', '5',
	'--max-sleep-interval', '30',
	'--live-from-start',
	'--ignore-errors',
	'--no-continue',
	'--no-overwrites',
	'--add-metadata',
	'--write-description',
	'--write-info-json',
	'--write-annotations',
	'--write-thumbnail',
	'--embed-thumbnail',
	'--skip-unavailable-fragments',
	'--check-formats',
	'--concurrent-fragments', $Config.MediaConcurrentFragments,
	'--sponsorblock-mark', 'all,-poi_highlight,-filler',
	'--output', "$($Config.OutputBase)/$($Config.YTDLPOutputFormat)"
)

yt-dlp @CookieConfig @Command @args *>&1
