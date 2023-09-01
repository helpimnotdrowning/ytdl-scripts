ytarchive  `
--trace `
--cookies $(get-content "$PSScriptRoot/__cookies_file_path.txt") `
--add-metadata `
--no-merge `
--write-description `
--write-thumbnail `
--retry-stream 60 `
--threads $(get-content "$PSScriptRoot/__concurrent-fragments-data.txt") `
--output "%(channel)s/%(upload_date)s - %(title)s/%(title)s [%(id)s] LIVE" `
$args best

# ytarchive has very slightly different output template syntax!

# TODO: Conditionally include --cookies flag depending on if cookies file exists.