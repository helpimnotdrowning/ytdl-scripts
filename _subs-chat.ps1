yt-dlp `
--format "best" `
--verbose `
--skip-download `
--force-ipv4 `
--ignore-errors `
--no-continue `
--no-overwrites `
--cookies-from-browser $(get-content ./__browser.txt) `
--sub-format "ass/srv3/vtt/best" `
--all-subs `
--throttled-rate 100K `
--retries infinite `
--concurrent-fragments $(get-content ./__concurrent-fragments-data.txt) `
--no-part `
--output $(get-content ./__output-format.txt) `
$args 2>&1
