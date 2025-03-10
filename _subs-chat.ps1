$Config = Get-Content -Raw "$PSScriptRoot/Config.json5" | ConvertFrom-Json

$CookieConfig = $Config.AlwaysUseCookiesFile ? @('--cookies', $Config.CookiesFilePath) : @('--cookies-from-browser', $Config.CookiesBrowser)

$Command = @(
    '--verbose',
    '--format', "b",
    '--skip-download',
    '--force-ipv4',
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

yt-dlp @CookieConfig @Command @args
