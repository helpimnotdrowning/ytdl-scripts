$command = @(
    'yt-dlp',
    '--downloader', 'aria2c',
    '--downloader-args', "`"--continue --max-concurrent-downloads=16 --max-connection-per-server=16 --split=16 --min-split-size=5M`"",
    '--force-ipv4',
    '--keep-video'
) + $(If ((get-content "$PSScriptRoot/__always_use_cookies_file.txt") -match "true") {
    @('--cookies', "`"$(get-content "$PSScriptRoot/__cookies_file_path.txt")`"")
} Else {
    '--cookies-from-browser', "`"$(get-content "$PSScriptRoot/__browser.txt")`""
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
    '--concurrent-fragments', "`"$(get-content "$PSScriptRoot/__concurrent-fragments-media.txt")`"",
    '--output', "`"$(get-content "$PSScriptRoot/__output-format.txt")`"",
    '--throttled-rate', '100K',
    $(& "$PSScriptRoot/Repair-ArgumentsToString" $args),
    "2>&1"
) -join ' '

Invoke-Expression -Command $command