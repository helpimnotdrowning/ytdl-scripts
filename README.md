A collection of scripts for archival purposes.

DEPENDENCIES: [`yt-dlp`](https://github.com/yt-dlp/yt-dlp), [`ytarchive`](https://github.com/Kethsar/ytarchive), [`youtube-community-tab`](https://github.com/bot-jonas/youtube-community-tab), `ffmpeg`

To change most-needed settings, edit files beginning with "__" (double underscores)

Use `dl.ps1` for an """interactive""" picker that shows all your options, along with auto-fallthrough for `youtube.com/live` streams and (non-clip) `twitch.tv` streams/VODs. It requires at least one argument, being the video link. Any other arguments are passed directly onto the downloader script.

`__browser.txt`
- Your browser to extract auth cookies from
- One of `brave, chrome, chromium, edge, firefox, opera, safari, vivaldi`

`__concurrent-fragments-(data,media).txt`
- Fragments to download concurrently (download threading)
- I've found that using more threads for data has little effect, where 10 threads is about the limit for videos before being limited by YouTube
- Can be any integer, but try to keep data threads low. `403 Forbidden` in output means you're probably being limited and need to turn these down

`__output-base.txt`
- Base path to download to
- Use only normal slashes "/", must end with a slash
- Use "./" to always write to the working directory.

`__output-format.txt`
- Output filename format template for everything EXCEPT `(2) YouTube stream` and `(5) YouTube community posts`, as these don't use yt-dlp
- Use [this guide](https://github.com/yt-dlp/yt-dlp#output-template ) to write templates.

`__cookies_file_path.txt`
- Path to your `cookies.txt` file
- This is only used for `(2) YouTube stream` and `(5) YouTube community posts`, since don't use yt-dlp and can't extract cookies from the browser automatically.