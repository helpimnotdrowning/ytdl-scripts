~\youtube-community-tab\ytct.py `
--cookies $(get-content "$PSScriptRoot/__cookies_file_path.txt") `
--dates `
$args

# TODO: Conditionally include --cookies flag depending on if cookies file exists.