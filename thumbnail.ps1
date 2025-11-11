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
	'--sleep-requests', '1',
	'--sleep-interval', '5',
	'--max-sleep-interval', '30',
	'--ignore-errors',
	'--no-continue',
	'--no-overwrites',
	'--write-thumbnail',
	'--check-formats',
	'--skip-download',
	'--concurrent-fragments', $Config.MediaConcurrentFragments,
	'--output', "$($Config.OutputBase)/$($Config.YTDLPOutputFormat)" # THIS COMMA IS PURPOSFULLY MISSING!!
)

yt-dlp @CookieConfig @Command @args *>&1
