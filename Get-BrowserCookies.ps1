param(
	[String] $Browser,
	[String] $BasePath
)

$CookiePath = ((Split-Path $BasePath) + "/extracted-$Browser-" + (Split-Path -Leaf "$BasePath")) -replace '\\','/'

# prevent previously-executed program's result from creeping in
Remove-Variable LASTEXITCODE -ErrorAction Ignore

Write-Warning "Dumping browser '$Browser' cookies to $CookiePath, ignore the upcoming error message from yt-dlp..."
yt-dlp --cookies-from-browser $Browser --cookies $CookiePath

sleep 1

if ($LASTEXITCODE -ne 0) {
	return ""
	
} else {
	return $CookiePath
	
}
