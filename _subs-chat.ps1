$Config = Get-Content -Raw "$PSScriptRoot/Config.json5" | ConvertFrom-Json

$Command = @(
    'yt-dlp',
    '--format', "best",
    '--verbose',
    '--skip-download',
    '--force-ipv4',
    '--ignore-errors',
    '--no-continue',
    '--no-overwrites'
) + $(If ($Config.AlwaysUseCookiesFile) {
    @('--cookies', "`"$($Config.CookiesFilePath)`"")
    
} Else {
    '--cookies-from-browser', "$($Config.CookiesBrowser)"
    
}) + @(
    '--sub-format', "ass/vtt/srv3/best",
    '--all-subs',
    '--throttled-rate', '100K',
    '--retries', 'infinite',
    '--concurrent-fragments', "$($Config.DataConcurrentFragments)",
    '--no-part',
    '--output', "`"$($Config.OutputBase)/$($Config.YTDLPOutputFormat)`"",
    $(& "$PSScriptRoot/Repair-ArgumentsToString" $args),
    "2>&1"
) -join ' '

Invoke-Expression -Command $Command