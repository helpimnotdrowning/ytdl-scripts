$Config = Get-Content -Raw "$PSScriptRoot/Config.json5" | ConvertFrom-Json

$Command = @(
    'yt-dlp',
    '--downloader', 'aria2c',
    '--downloader-args', "`"--continue --max-concurrent-downloads=16 --max-connection-per-server=16 --split=16 --min-split-size=5M`"",
    '--force-ipv4',
    '--keep-video'
) + $(If ($Config.AlwaysUseCookiesFile) {
    @('--cookies', "`"$($Config.CookiesFilePath)`"")
    
} Else {
    '--cookies-from-browser', "$($Config.CookiesBrowser)"
    
}) + @(
    '--ignore-errors',
    '--no-continue',
    '--no-overwrites',
    '--add-metadata',
    '--write-description',
    '--write-info-json',
    '--write-annotations',
    '--write-thumbnail',
    '--embed-thumbnail',
    '--all-subs',
    '--embed-subs',
    '--get-comments',
    '--check-formats',
    '--concurrent-fragments', "$($Config.MediaConcurrentFragments)",
    '--output', "`"$($Config.OutputBase)/$($Config.YTDLPOutputFormat)`"",
    '--throttled-rate', '100K',
    $(& "$PSScriptRoot/Repair-ArgumentsToString" $args),
    "2>&1"
) -join ' '

Invoke-Expression -Command $Command