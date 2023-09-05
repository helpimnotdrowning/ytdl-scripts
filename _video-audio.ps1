$command = @(
    'yt-dlp',
    '--format', "bestvideo[vcodec^=avc]+bestaudio[acodec^=mp4a]/bestvideo+bestaudio/best"
    '--force-ipv4',
    '--sleep-requests 1',
    '--sleep-interval 5',
    '--max-sleep-interval 15',
    '--ignore-errors',
    '--no-continue',
    '--no-overwrites',
    '--no-write-info-json'
) + $(If ((get-content "$PSScriptRoot/__always_use_cookies_file.txt") -match "true") {
    @('--cookies', "`"$(get-content "$PSScriptRoot/__cookies_file_path.txt")`"")
} Else {
    '--cookies-from-browser', "`"$(get-content "$PSScriptRoot/__browser.txt")`""
}) + @(
    '--check-formats',
    '--throttled-rate 100K',
    '--retries infinite',
    '--concurrent-fragments', "`"$(get-content "$PSScriptRoot/__concurrent-fragments-media.txt")`"",
    '--merge-output-format mkv',
    '--remux-video mkv',
    '--embed-chapters',
    '--no-part',
    '--sponsorblock-mark', 'all,-poi_highlight,-filler',
    '--output', "`"$(get-content "$PSScriptRoot/__output-format.txt")`"",
    $(& "$PSScriptRoot/Repair-ArgumentsToString" $args),
    "2>&1"
) -join ' '

Invoke-Expression -Command $command