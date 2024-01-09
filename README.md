A collection of scripts for archival purposes.

DEPENDENCIES: [`yt-dlp`](https://github.com/yt-dlp/yt-dlp), [`ytarchive`](https://github.com/Kethsar/ytarchive), [`youtube-community-tab`](https://github.com/bot-jonas/youtube-community-tab), `ffmpeg`

Edit the `Config.json5` file to change settings.

Use `PS> dl.ps1 <link>` to interactively select a download script with descriptions, with auto-fallthrough for `youtube.com/live` streams and (non-clip) `twitch.tv` streams/VODs to their respective downloaders.

# Settings

## Config.OutputBase
* **[String]** Generic base path for downloaders. MUST end with a slash!
* Ex 
  * "/mnt/W/ytdl/"
  * "./"
  * "C:/Users/User/Download/"

## Config.YTDLPOutputFormat, Config.YTARCHIVEOutputFormat
* **[String]** File name format for scripts using yt-dlp or ytarchive
* They both have different output format labels and can't share it between eachother. Recommended to keep them in sync
* Ex
  * (yt-dlp) "%(uploader)s/$(upload_date)s - $(title)s/%(title)s [$(id)s] f%(format_id)s.$(ext)s"
  * (ytarchive) "%(channel)s/%(upload_date)s - %(title)s/%(title)s [%(id)s] LIVE"

## Config.AlwaysUseCookiesFile
* **[Bool: true|false]** Whether to "always" use a cookies file instead of "whenever possible"
* This setting only affects scripts using yt-dlp, ytarchive cannot read cookies from the browser and will always use the cookies file

## Config.CookiesFilePath
* **[String]** Cookie file path.
* At minimum required for ytarchive scripts when AlwaysUseCookiesFile = false, otherwise this is is always needed.
* Ex
  * "C:/Users/User/cookies.txt"
  * "/mnt/W/ytdl/cookies.txt"

## Config.CookiesBrowser
* **[String: brave | chrome | chromium | edge | firefox | opera | safari | vivaldi]** Browser for yt-dlp to auto-extract cookies from when AlwaysUseCookiesFile = true

## Config.MediaConcurrentFragments, Config.DataConcurrentFragments
**NOTE ABOUT CONCURRENT FRAGMENTS:**
I recommend keeping the defaults pre-set, I have tested these thouroughly and have determined
that this is about the upper limit before YouTube begins throttling your connection or temp. blocking your IP.
I am, however, in the US with a reasonably good connection, so if you find your download speed lacking or are
being throttled (`WARNING: The download speed is below throttle limit` or `Got error: HTTP Error 403: Forbidden`)
then feel free to play around with these values.

* **[Int]** Amount of simultanious connections allowed for video/audio (media) and subs, thumbnails, comments, not-video/audio (data)
