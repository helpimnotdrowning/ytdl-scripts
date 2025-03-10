$Config = Get-Content -Raw "$PSScriptRoot/Config.json5" | ConvertFrom-Json

$CookieConfig = $Config.AlwaysUseCookiesFile ? @('--cookies', $Config.CookiesFilePath) : @('--cookies-from-browser', $Config.CookiesBrowser)

$Command = @(
	'--verbose',
	'--format', "bestvideo[vcodec^=avc]+bestaudio[acodec^=mp4a]/bestvideo+bestaudio/best",
	'--force-ipv4',
	'--sleep-requests', '1',
	'--sleep-interval', '5',
	'--max-sleep-interval', '6',
	'--ignore-errors',
	'--no-continue',
	'--no-overwrites',
	'--no-write-info-json',
	'--check-formats',
	'--throttled-rate', '100K',
	'--retries', 'infinite',
	'--concurrent-fragments', $Config.MediaConcurrentFragments,
	'--embed-chapters',
	'--no-part',
	'--embed-metadata',
	'--parse-metadata', '%(upload_date>%Y-%m-%d)s:%(meta_date)s', # format date as yyyy-MM-dd
	'--parse-metadata', ':(?P<meta_synopsis>)', # don't store description in synopsis
	'--parse-metadata', ':(?P<meta_description>)', # don't store description in description
	'--parse-metadata', 'description:(?s)(?P<meta_comment>.+)', # store description in comment
	'--replace-in-metadata', '"meta_comment" "\n" "\r\n"', # replace \n with \r\n for display compat. with mp3tag (would otherwise render as one line)
	'--sponsorblock-mark', 'all,-poi_highlight,-filler',
	'--output', "$($Config.OutputBase)/musicvideo/[%(upload_date>%Y-%m-%d)s] [yt-%(id)s] %(title)s - %(uploader)s.%(ext)s"
)

yt-dlp @CookieConfig @Command @args *>&1
