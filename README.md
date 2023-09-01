A collection of scripts for archival purposes.

To change most-needed settings, edit files beginning with "__", they should follow the specifications on [the yt-dlp repo](https://github.com/yt-dlp/yt-dlp)

Use `dl.ps1` for an """interactive""" picker that shows all your options, along with auto-fallthrough for `youtube.com/live` streams and (non-clip) `twitch.tv` streams/VODs. It requires at least one argument, being the video link. Any other arguments are passed directly onto the downloader script.