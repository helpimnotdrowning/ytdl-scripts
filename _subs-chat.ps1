$Config, $ExtraFlags = (& "$PSScriptRoot/__load-config.ps1" -ConfigFile "$PSScriptRoot/Config.json5")

$Command = @(
    '--verbose',
    '--format', "b",
    '--skip-download',
    '--force-ipv4',
    '--sleep-requests', $Config.ArchiveDataSleep,
    '--sleep-interval', $Config.ArchiveSleepMin,
    '--max-sleep-interval', $Config.ArchiveSleepMax,
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

yt-dlp @ExtraFlags @Command @args *>&1
