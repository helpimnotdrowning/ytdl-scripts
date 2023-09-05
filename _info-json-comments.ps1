$command = @(
    'yt-dlp',
    '--format', "best",
    '--force-ipv4',
    '--sleep-requests', '.25',
    '--sleep-interval', '5',
    '--max-sleep-interval', '15',
    '--ignore-errors',
    '--no-continue',
    '--no-overwrites',
    '--write-description',
    '--write-info-json',
    '--write-comments'
) + $(If ((get-content "$PSScriptRoot/__always_use_cookies_file.txt") -match "true") {
    @('--cookies', "`"$(get-content "$PSScriptRoot/__cookies_file_path.txt")`"")
} Else {
    '--cookies-from-browser', "`"$(get-content "$PSScriptRoot/__browser.txt")`""
}) + @(
    '--check-formats',
    '--throttled-rate', '100K'
    '--retries', 'infinite'
    '--concurrent-fragments', "`"$(get-content "$PSScriptRoot/__concurrent-fragments-data.txt")`"",
    '--no-part',
    '--sponsorblock-mark', 'all,-poi_highlight,-filler'
    '--skip-download',
    '--output', "`"$(get-content "$PSScriptRoot/__output-format.txt")`"",
    $(& "$PSScriptRoot/Repair-ArgumentsToString" $args),
    "2>&1"
) -join ' '

Invoke-Expression -Command $command