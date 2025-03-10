<#
.SYNOPSIS
	Export browser cookies using yt-dlp
.DESCRIPTION
	Export browser cookies using yt-dlp. Takes a yt-dlp browser string (see
	https://github.com/yt-dlp/yt-dlp/blob/master/README.md about
	`cookies-from-browser`) and returns the cookie file path, or nothing if
	the extraction failed. User must delete the cookie file themselves.
#>
function Export-BrowserCookies {
	param(
		[String] $Browser
	)

	$CookiePath = "Temp:/nhnd-cookies-$(new-guid)"

	# prevent previously-executed program's result from creeping in
	Remove-Variable LASTEXITCODE -ErrorAction Ignore

	Write-Debug "Dumping browser '$Browser' cookies to $CookiePath"
	yt-dlp --cookies-from-browser $Browser --cookies $CookiePath | Out-Null

	sleep 1

	if (Test-Path $CookiePath) {
		return (get-item $CookiePath).FullName
		
	} else {
		return ""
		
	}
}

<#
.SYNOPSIS
	Remove all browser cookie exports living in Temp:
.DESCRIPTION
	Remove all browser cookie exports living in Temp:. This should NOT be used
	by scripts to delete their own cookies after they're done with them, they
	should work with the file path returned by `Exported-BrowserCookies`!
#>
function Remove-ExportedBrowserCookies {
	Remove-Item Temp:/nhnd-cookies-*
}
