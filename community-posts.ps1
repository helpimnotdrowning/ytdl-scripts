$Config = Get-Content -Raw "$PSScriptRoot/Config.json5" | ConvertFrom-Json


if (-not Test-Path )
$CookiePath = & "$PSScriptRoot\Get-BrowserCookies.ps1" -Browser $Config.CookiesBrowser -BasePath $Config.CookiesFilePath

if ($CookiePath -eq "") {
	
}

$Command = @(
	'--cookies', $CookiePath,
	'--dates' # THIS COMMA IS PURPOSFULLY MISSING!!
	$args
)

~/youtube-community-tab/ytct.py @Command *>&1

# TODO: Conditionally include --cookies flag depending on if cookies file exists.