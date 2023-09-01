ytarchive  `
--trace `
--cookies cookies.txt `
--add-metadata `
--no-merge `
--write-description `
--write-thumbnail `
--retry-stream 60 `
--threads $(get-content ./__concurrent-fragments-data.txt) `
--output "%(channel)s/%(upload_date)s - %(title)s/%(title)s [%(id)s] LIVE" `
$args best

# ytarchive has very slightly different output template syntax!
