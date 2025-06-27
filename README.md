A collection of scripts for archival purposes.

DEPENDENCIES: [`yt-dlp`](https://github.com/yt-dlp/yt-dlp), [`youtube-community-tab`](https://github.com/bot-jonas/youtube-community-tab), `ffmpeg`

Copy the provided `Config.exp.json5` file to `Config.json5` to create your settings.

Use `dl.ps1 <link>` to interactively select a download script with descriptions, with auto-fallthrough for `youtube.com/live` streams and (non-clip) `twitch.tv` streams/VODs to their respective downloaders.

# Settings

## Config.OutputBase
* **[String]** Generic base path for downloaders.
* Ex,
  * `"/mnt/W/ytdl"`
  * `"./"`
  * `"C:/Users/User/Download/"`

## Config.YTDLPOutputFormat
* **[String]** File name format for yt-dlp
* Ex `"%(uploader)s/%(upload_date)s - %(id)s - %(title)s/%(title)s [%(id)s] f%(format_id)s.%(ext)s`

## Config.NoCookies
* **[Bool: true|false]** Whether to use cookies at all, or have them disabled.

## Config.AlwaysUseCookiesFile
* **[Bool: true|false]** Always use `Config.CookiesFilePath` as the cookie provider instead of the browser

## Config.CookiesFilePath
* **[String]** Cookie file path.
* Needed when `Config.AlwaysUseCookiesFile` is true
* Ex
  * `"C:/Users/User/cookies.txt"`
  * `"/mnt/W/ytdl/cookies.txt"`

## Config.CookiesBrowser
* **[String: `chrome` | `firefox` | ...]** Browser for yt-dlp to auto-extract cookies from when `AlwaysUseCookiesFile` is false
* See the [yt-dlp README#Filesystem Options](https://github.com/yt-dlp/yt-dlp/blob/master/README.md#filesystem-options) for supported browsers 

## Config.ArchiveSleepMin, ArchiveSleepMax, ArchiveDataSleep
* **[Int]** `full` and its children scripts use a different sleep duration than other scripts. This helps prevent temp bans by YouTube (and probably other platforms) from mass downloads, like entire channels.

## Config.MediaConcurrentFragments, Config.DataConcurrentFragments
**NOTE ABOUT CONCURRENT FRAGMENTS:**
I recommend keeping the defaults pre-set, I have tested these somewhat-thouroughly and have determined
that this is about the upper limit before YouTube begins throttling your connection or temp. blocking your IP.
I am, however, in the US with a reasonably good connection, so if you find your download speed lacking or are
being throttled (`WARNING: The download speed is below throttle limit` or `Got error: HTTP Error 403: Forbidden`)
then feel free to play around with these values.

* **[Int]** Amount of simultanious connections allowed for video/audio (media) and subs, thumbnails, comments, not-video/audio (data).
