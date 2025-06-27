#param (
#	$ArchiveFile
#)

if ($ArchiveFile) {
	& "$PSScriptRoot\_video-audio.ps1" @args --download-archive "$ArchiveFile.video-audio"
	& "$PSScriptRoot\_info-json-comments.ps1" @args --download-archive "$ArchiveFile.info-comments"
	& "$PSScriptRoot\_subs-chat.ps1" @args --download-archive "$ArchiveFile.subs-chat"
} else {
	& "$PSScriptRoot\_video-audio.ps1" @args
	& "$PSScriptRoot\_info-json-comments.ps1" @args
	& "$PSScriptRoot\_subs-chat.ps1" @args
	
}
