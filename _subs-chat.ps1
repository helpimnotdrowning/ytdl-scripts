$command = @(
    'yt-dlp',
    '--format', "best",
    '--verbose',
    '--skip-download',
    '--force-ipv4',
    '--ignore-errors',
    '--no-continue',
    '--no-overwrites'
) + $(If ((get-content "$PSScriptRoot/__always_use_cookies_file.txt") -match "true") {
    @('--cookies', "`"$(get-content "$PSScriptRoot/__cookies_file_path.txt")`"")
} Else {
    '--cookies-from-browser', "`"$(get-content "$PSScriptRoot/__browser.txt")`""
}) + @(
    '--sub-format', "ass/srv3/vtt/best",
    '--all-subs',
    '--throttled-rate', '100K',
    '--retries', 'infinite',
    '--concurrent-fragments', "`"$(get-content "$PSScriptRoot/__concurrent-fragments-data.txt")`"",
    '--no-part',
    '--output', "`"$(get-content "$PSScriptRoot/__output-format.txt")`"",
    $(& "$PSScriptRoot/Repair-ArgumentsToString" $args),
    "2>&1"
) -join ' '

Invoke-Expression -Command $command