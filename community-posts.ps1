$Config = Get-Content -Raw "$PSScriptRoot/Config.json5" | ConvertFrom-Json

Write-Warning "Dumping browser cookies to $($Config.CookiesFilePath), ignore the upcoming error message from yt-dlp..."
yt-dlp --cookies-from-browser $Config.CookiesBrowser --cookies $Config.CookiesFilePath

$Command = @(
	'--cookies', $Config.CookiesFilePath,
	'--dates'
)

~/youtube-community-tab/ytct.py @Command @args *>&1
