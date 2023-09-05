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

If (-not (Test-Path $(get-content "$PSScriptRoot/__cookies_file_path.txt") -PathType Leaf)) {
    Write-Warning "Watch out! The cookies.txt file specified in $PSScriptRoot/__cookies_file_path.txt doesn't exist!"
    Write-Warning "Scripts `"(2) YouTube stream`" and `"(5) YouTube community posts`" will not capture paywalled or otherwise account-restricted content without this!"
}

$YEL = $PSStyle.Foreground.Yellow
$000 = $PSStyle.Reset
$GRY = $PSStyle.Foreground.BrightBlack

Write-Host "What would you like to do with link $($args[0])? Choose [1->8]"
Write-Host "($YEL`1$000) $YEL`STANDARD$000 $GRY[standard-processed]$000"
Write-Host "    - Video, metadata, subs for pretty much EVERYTHING"
Write-Host "($YEL`2$000) $YEL`YouTube stream$000 $GRY[stream-unprocessed]$000"
Write-Host "    -`Future or in-progress; video only, metadata if not privated"
Write-Host "($YEL`3$000) $YEL`Twitch stream$000 $GRY[twitch]$000"
Write-Host "    -`Past or present, future may work?; video and metadata"
Write-Host "($YEL`4$000) $YEL`FULL$000 $GRY[full]$000"
Write-Host "    -`Video, metadata, subs, comments, probably more I forgot, best on YouTube but working anywhere else"
Write-Host "($YEL`5$000) $YEL`YouTube community posts$000 $GRY[community-posts]$000"
Write-Host "    -`Public and Members, when joined"
Write-Host "($YEL`6$000) $YEL`Video + Audio only$000 $GRY[_video-audio]$000"
Write-Host "    -`MP4/AAC preferred, fallback to yt-dlp 'best' format"
Write-Host "($YEL`7$000) $YEL`Subtitles + Live Chat only$000 $GRY[_subs-chat]$000"
Write-Host "    -`Only real languages, no auto captions. Live chat may or may not be only for YouTube, idk"
Write-Host "($YEL`8$000) $YEL`Metadata + Comments only$000 $GRY[_info-json-comments]$000"
Write-Host "    - Full metadata (info.json, description) and ALL comments present."

$choice = Read-Host
Switch ($choice) {
    1 {&"$PSScriptRoot/standard-processed" $args}
    2 {&"$PSScriptRoot/stream-unprocessed" $args}
    3 {&"$PSScriptRoot/twitch" $args}
    4 {&"$PSScriptRoot/full" $args}
    5 {&"$PSScriptRoot/community-posts" $args}
    6 {&"$PSScriptRoot/_video-audio" $args}
    7 {&"$PSScriptRoot/_subs-chat" $args}
    8 {&"$PSScriptRoot/_info-json-comments" $args}
    default {Write-Host "Invalid choice, choose a number between 1 and 8!"; exit}
}