param (
	[String] $ConfigFile
)

if ([String]::IsNullOrWhitespace($ConfigFile)) {
	$ConfigFile = "$PSScriptRoot/Config.json5"
}

<# ### ### ### #>

$Config = Get-Content -Raw $ConfigFile | ConvertFrom-Json

$ExtraFlags = @()

if ($Config.NoCookies) {
	$ExtraFlags += @('--no-cookies')
} else {
	$ExtraFlags += $Config.AlwaysUseCookiesFile ? @('--cookies', $Config.CookiesFilePath) : @('--cookies-from-browser', $Config.CookiesBrowser)
}

if ($Config.JsRuntime -in 'none','',$null) {
	$ExtraFlags += @('--no-js-runtimes')
} else {
	$ExtraFlags += @('--js-runtimes', $Config.JsRuntime)
}

return @($Config, $ExtraFlags)
