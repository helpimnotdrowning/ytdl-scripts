param (
	[Parameter(Mandatory)]
	[String] $URL,
	
	[String[]] $ExtraArgs,

	[Int] $Choice
)


function Read-HostNumberMenu {
    param (
        [String] $Query,
        [String[][]] $Options
    )
    
    $YEL = $PSStyle.Foreground.Yellow
    $000 = $PSStyle.Reset
    $GRY = $PSStyle.Foreground.BrightBlack
    
    $Selection = 4
    $Attempted = $false
    
    Write-Host "`n$Query`n"
    
    for ($i = 0; $i -lt $Options.Count; $i++) {
        Write-Host "$YEL[$($i+1)] $($Options[$i][0])$000 $GRY[$($Options[$i][1])]$000"
        Write-Host "    - $($Options[$i][2])"
    }
    
     do {
        if ($Attempted) {
            Write-Host "$000`That wasn't a valid option."
        }
        
        Write-Host "$000`nYour selection ( " -NoNewline
        
        for ($i = 0; $i -lt $Options.Count; $i++) {
            if ($i+1 -eq $Options.Count) {
                Write-Host "$YEL$($i+1)$000 ) : $YEL" -NoNewLine
            } else {
                Write-Host "$YEL$($i+1)$000 | " -NoNewLine
            }
        }
        
        $Selection = Read-Host
        Write-Host $000
        
        $Attempted = $true
        
    } while (-not (($Selection -le $Options.Count) -and ($Selection -ge 1)))
    
    return $Selection
}

$Config = Get-Content -Raw "$PSScriptRoot/Config.json5" | ConvertFrom-Json

# Auto-detect YouTube live stream
#if ($args[0] -match "^(http(s)?:\/\/)?.*\.?youtube\.com\/live\/") {
if ($URL -like "*youtube.com/live/*") {
	./stream-unprocessed $URL @ExtraArgs
	exit
}

# Auto-detect Twitch links EXCEPT for clips
#if (($args[0] -match "^(http(s)?:\/\/)?.*\.?twitch\.tv\/") -and -not ($args[0] -match "^(http(s)?:\/\/)?clips\.?twitch\.tv\/")) {
if (($URL -like "*twitch.tv*") -and ($URL -notlike "*clips.twitch.tv/*")) {
	./twitch.ps1 $URL @ExtraArgs
	exit
}

# not needed? cookies are dumped on start for (2) and (5)
#if (-not (Test-Path $Config.CookiesFilePath -PathType Leaf)) {
#    Write-Warning "Watch out! The cookies.txt file specified in Config.CookiesFilePath doesn't exist!"
#    Write-Warning "Scripts `"(2) YouTube stream`" and `"(5) YouTube community posts`" will not capture paywalled or otherwise account-restricted content without this!"
#}

Write-Warning "URL: $URL"
Write-Warning "EXTRA ARGS: @ExtraArgs"


# choice param is optional, if not used (-eq 0), interactively pick
if ($Choice -eq 0) {
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
	
	#if ($args)
	$Choice = Read-HostNumberMenu -Query "What would you like to do with link `"$URL`"?" -Options $Options
	
}

switch ($Choice) {
	1 { &"$PSScriptRoot/standard-processed" $URL @ExtraArgs }
	2 { &"$PSScriptRoot/stream-unprocessed" $URL @ExtraArgs }
	3 { &"$PSScriptRoot/twitch" $URL @ExtraArgs }
	4 { &"$PSScriptRoot/full" $URL @ExtraArgs }
	5 { &"$PSScriptRoot/community-posts" $URL @ExtraArgs }
	6 { &"$PSScriptRoot/_video-audio" $URL @ExtraArgs }
	7 { &"$PSScriptRoot/_subs-chat" $URL @ExtraArgs }
	8 { &"$PSScriptRoot/_info-json-comments" $URL @ExtraArgs }
	9 { &"$PSScriptRoot/musicvideo" $URL @ExtraArgs }
	default {Write-Error "Invalid choice, must be within 1-9, wrote `"$Choice`""; exit}
}
