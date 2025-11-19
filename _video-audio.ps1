$Config, $ExtraFlags = (& "$PSScriptRoot/__load-config.ps1" -ConfigFile "$PSScriptRoot/Config.json5")

$Command = @(
    '--verbose',
    '--format', "bestvideo[vcodec^=avc]+bestaudio[acodec^=mp4a]/bestvideo+bestaudio/best",
    '--force-ipv4',
    '--sleep-requests', $Config.ArchiveDataSleep,
    '--sleep-interval', $Config.ArchiveSleepMin,
    '--max-sleep-interval', $Config.ArchiveSleepMax,
    '--ignore-errors',
    '--no-continue',
    '--no-overwrites',
    '--no-write-info-json',
    '--check-formats',
    '--throttled-rate', '100K',
    '--retries', 'infinite',
    '--concurrent-fragments', $Config.MediaConcurrentFragments,
    '--merge-output-format', 'mkv',
    '--remux-video', 'mkv',
    '--embed-chapters',
    '--no-part',
    '--sponsorblock-mark', 'all,-poi_highlight,-filler',
    '--output', "$($Config.OutputBase)/$($Config.YTDLPOutputFormat)"
)

yt-dlp @ExtraFlags @Command @args *>&1
