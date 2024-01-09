function Read-HostNumberMenu {
    param (
        [String] $Query,
        [String[][]] $Options
    )
    
    $YEL = $PSStyle.Foreground.Yellow
    $000 = $PSStyle.Reset
    $GRY = $PSStyle.Foreground.BrightBlack
    
    [Int] $Selection = 4
    [Bool] $Attempted = $false
    
    Write-Host "`n$Query`n"
    
    for ($i = 0; $i -lt $Options.Count; $i++) {
        Write-Host "$YEL[$($i+1)] $($Options[$i][0])$000 $GRY[$($Options[$i][1])]$000"
        Write-Host "    - $($Options[$i][2])"
    }
    
     do {
        If ($Attempted) {
            Write-Host "$000`That wasn't a valid option."
        }
        
        Write-Host "$000`nYour selection ( " -NoNewline
        
        for ($i = 0; $i -lt $Options.Count; $i++) {
            If ($i+1 -eq $Options.Count) {
                Write-Host "$YEL$($i+1)$000 ) : $YEL" -NoNewLine
            } Else {
                Write-Host "$YEL$($i+1)$000 | " -NoNewLine
            }
        }
        
        $Selection = Read-Host
        Write-Host $000
        
        $Attempted = $true
        
    } while (!($Selection -le $Options.Count -and $Selection -ge 1))
    
    Return $Selection
}

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


$Options = @(
    @(
        "STANDARD",
        "standard-processed",
        "Video, metadata, subs for pretty much EVERYTHING"
    ),
    @(
        "YouTube Stream",
        "stream-unprocessed",
        "Future or in-progress; video only, metadata if not privated"
    ),
    @(
        "Twitch Stream",
        "twitch",
        "Past or present, future may work?; video and metadata"
    ),
    @(
        "FULL ARCHIVE",
        "full",
        "Video, metadata, subs, comments, probably more I forgot, best on YouTube but probably working anywhere else"
    ),
    @(
        "YouTube Community Posts",
        "community-posts",
        "Public and Members, when joined"
    ),
    @(
        "Video + Audio Only",
        "_video-audio",
        "MP4/AAC preferred, fallback to yt-dlp 'best' format"
    ),
    @(
        "Subtitles + Live Chat Only",
        "_subs-chat",
        "Only real languages, no auto captions. Live chat may or may not be only for YouTube, idk"
    ),
    @(
        "Metadata + Comments Only",
        "_info-json-comments",
        "Full metadata (info.json, description) and ALL comments present"
    ),
    @(
        "Music Videos",
        "musicvideo",
        "Special format for downloading YouTube music videos for my music collection"
    )
)
 
$choice = Read-HostNumberMenu -Query "What would you like to do with link $($args[0]) ?" -Options $Options

Switch ($choice) {
    1 {&"$PSScriptRoot/standard-processed" $args}
    2 {&"$PSScriptRoot/stream-unprocessed" $args}
    3 {&"$PSScriptRoot/twitch" $args}
    4 {&"$PSScriptRoot/full" $args}
    5 {&"$PSScriptRoot/community-posts" $args}
    6 {&"$PSScriptRoot/_video-audio" $args}
    7 {&"$PSScriptRoot/_subs-chat" $args}
    8 {&"$PSScriptRoot/_info-json-comments" $args}
    9 {&"$PSScriptRoot/musicvideo" $args}
    default {Write-Error "Invalid choice, choose a number between 1 and 9! You wrote $choice!"; exit}
}