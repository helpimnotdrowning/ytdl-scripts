$Config, $ExtraFlags = (& "$PSScriptRoot/__load-config.ps1" -ConfigFile "$PSScriptRoot/Config.json5")

$Command = @(
    '--verbose',
    '--format', 'bestvideo[vcodec^=avc]+bestaudio[acodec^=mp4a]/bestvideo+bestaudio/best'
    '--downloader', 'aria2c',
    '--downloader-args', "--continue --max-concurrent-downloads=8 --max-connection-per-server=8 --split=8 --min-split-size=5M",
    '--force-ipv4',
    '--keep-video',
    '--ignore-errors',
    '--no-continue',
    '--no-overwrites',
    '--add-metadata',
    '--write-description',
    '--write-info-json',
    '--write-thumbnail',
    '--embed-thumbnail',
    '--all-subs',
    '--embed-subs',
    '--get-comments',
    '--check-formats',
    '--concurrent-fragments', $Config.MediaConcurrentFragments,
    '--output', "$($Config.OutputBase)/$($Config.YTDLPOutputFormat)",
    '--throttled-rate', '100K'
)

yt-dlp @ExtraFlags @Command @args *>&1
