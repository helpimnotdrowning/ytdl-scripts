$Config, $ExtraFlags = (& "$PSScriptRoot/__load-config.ps1" -ConfigFile "$PSScriptRoot/Config.json5")

$Command = @(
	'--verbose',
    '--format', "b",
    '--force-ipv4',
    '--sleep-requests', $Config.ArchiveDataSleep,
    '--sleep-interval', $Config.ArchiveSleepMin,
    '--max-sleep-interval', $Config.ArchiveSleepMax,
    '--ignore-errors',
    '--no-continue',
    '--no-overwrites',
    '--write-description',
    '--write-info-json',
    '--write-comments',
    '--write-thumbnail',
    '--check-formats',
    '--throttled-rate', '100K',
    '--retries', 'infinite',
    '--concurrent-fragments', $Config.DataConcurrentFragments,
    '--no-part',
    '--sponsorblock-mark', 'all,-poi_highlight,-filler',
    '--skip-download',
    '--output', "$($Config.OutputBase)/$($Config.YTDLPOutputFormat)"
)

yt-dlp @ExtraFlags @Command @args *>&1
