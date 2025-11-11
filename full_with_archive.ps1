[CmdletBinding(PositionalBinding=$false)]
param (
	$ArchiveFile,
	$Link,
	[String[]]$ExtraArgs
)

& "$PSScriptRoot\_video-audio.ps1" @ExtraArgs --download-archive "$ArchiveFile.video-audio" $Link
& "$PSScriptRoot\_info-json-comments.ps1" @aExtraArgs --download-archive "$ArchiveFile.info-comments" $Link
& "$PSScriptRoot\_subs-chat.ps1" @ExtraArgs --download-archive "$ArchiveFile.subs-chat" $Link
