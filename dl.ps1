# Auto-detect YouTube live stream
If ($args[0] -match "^(http(s)?:\/\/)?.*\.?youtube\.com\/live\/") {
    ./stream-unprocessed $args
    exit
}

# Auto-detect Twitch links EXCEPT for clips
If (($args[0] -match "^(http(s)?:\/\/)?.*\.?twitch\.tv\/") -and -not ($args[0] -match "^(http(s)?:\/\/)?clips\.?twitch\.tv\/")) {
    ./twitch.ps1 $args
    exit
}

Write-Host "What would you like to do with link $($args[0])? Choose [1->8]"
Write-Host "($($PSStyle.Foreground.Yellow)1$($PSStyle.Reset)) $($PSStyle.Foreground.Yellow)STANDARD$($PSStyle.Reset) $($PSStyle.Foreground.BrightBlack)[standard-processed]$($PSStyle.Reset)"
Write-Host "    - Video, metadata, subs for pretty much EVERYTHING"
Write-Host "($($PSStyle.Foreground.Yellow)2$($PSStyle.Reset)) $($PSStyle.Foreground.Yellow)YouTube stream$($PSStyle.Reset) $($PSStyle.Foreground.BrightBlack)[stream-unprocessed]$($PSStyle.Reset)"
Write-Host "    - Future or in-progress; video only, metadata if not privated"
Write-Host "($($PSStyle.Foreground.Yellow)3$($PSStyle.Reset)) $($PSStyle.Foreground.Yellow)Twitch stream$($PSStyle.Reset) $($PSStyle.Foreground.BrightBlack)[twitch]$($PSStyle.Reset)"
Write-Host "    - Past or present, future may work?; video and metadata"
Write-Host "($($PSStyle.Foreground.Yellow)4$($PSStyle.Reset)) $($PSStyle.Foreground.Yellow)FULL$($PSStyle.Reset) $($PSStyle.Foreground.BrightBlack)[full]$($PSStyle.Reset)"
Write-Host "    - Video, metadata, subs, comments, probably more I forgot, best on YouTube but working anywhere else"
Write-Host "($($PSStyle.Foreground.Yellow)5$($PSStyle.Reset)) $($PSStyle.Foreground.Yellow)YouTube community posts$($PSStyle.Reset) $($PSStyle.Foreground.BrightBlack)[community-posts]$($PSStyle.Reset)"
Write-Host "    - Public and Members, when joined"
Write-Host "($($PSStyle.Foreground.Yellow)6$($PSStyle.Reset)) $($PSStyle.Foreground.Yellow)Video + Audio only$($PSStyle.Reset) $($PSStyle.Foreground.BrightBlack)[_video-audio]$($PSStyle.Reset)"
Write-Host "    - MP4/AAC preferred, fallback to yt-dlp 'best' format"
Write-Host "($($PSStyle.Foreground.Yellow)7$($PSStyle.Reset)) $($PSStyle.Foreground.Yellow)Subtitles + Live Chat only$($PSStyle.Reset) $($PSStyle.Foreground.BrightBlack)[_subs-chat]$($PSStyle.Reset)"
Write-Host "    - Only real languages, no auto captions. Live chat may or may not be only for YouTube, idk"
Write-Host "($($PSStyle.Foreground.Yellow)8$($PSStyle.Reset)) $($PSStyle.Foreground.Yellow)Metadata + Comments only$($PSStyle.Reset) $($PSStyle.Foreground.BrightBlack)[_info-json-comments]$($PSStyle.Reset)"
Write-Host "    - Full metadata (info.json, description) and ALL comments present."

$choice = Read-Host

Switch ($choice) {
    1 {./standard-processed $args}
    2 {./stream-unprocessed $args}
    3 {./twitch $args}
    4 {./full $args}
    5 {./community-posts $args}
    6 {./_video-audio $args}
    7 {./_subs-chat $args}
    8 {./_info-json-comments $args}
    default {Write-Host "Invalid choice, choose a number between 1 and 8!"; exit}
}