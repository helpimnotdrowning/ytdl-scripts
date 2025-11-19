$Config = Get-Content -Raw "$PSScriptRoot/Config.json5" | ConvertFrom-Json

if ($Config.NoCookies) {
	$CookieConfig = @('--no-cookies')
} else {
	$CookieConfig = $Config.AlwaysUseCookiesFile ? @('--cookies', $Config.CookiesFilePath) : @('--cookies-from-browser', $Config.CookiesBrowser)
}

$Command = @(
	'--verbose',
	'--format', "bestvideo[vcodec^=avc]+bestaudio[acodec^=mp4a]/bestvideo+bestaudio/best",
	'--force-ipv4',
	'--sleep-requests', '1'
	'--sleep-interval', '5',
	'--max-sleep-interval', '30',
	'--live-from-start',
	'--ignore-errors',
#	'--no-continue',
	'--no-overwrites',
	'--add-metadata',
	'--write-description',
	'--write-info-json',
	'--write-thumbnail',
	'--embed-thumbnail',
	'--skip-unavailable-fragments',
	'--check-formats',
	'--wait-for-video', '60-600',
	'--concurrent-fragments', $Config.MediaConcurrentFragments,
	'--sponsorblock-mark', 'all,-poi_highlight,-filler',
	'--output', "$($Config.OutputBase)/$($Config.YTDLPOutputFormat)"
)

yt-dlp @CookieConfig @Command @args *>&1
