# Specify the path to the video file
$videoFilePath = "D:\aaa.mkv"

# Specify the path to the MediaInfo executable
# Be sure to use the CLI veriosn of MediaInfo
$mediaInfoPath = "D:\MediaInfo_CLI\MediaInfo.exe"

$output = & $mediaInfoPath "--output=JSON" $videoPath | ConvertFrom-Json
Write-Output "$([Math]::Round(($output.media.track[0].FileSize / [Math]::Pow(1024,2)), 2)) MB"

Write-Output $output.media.track[0].AudioCount
Write-Output $output.media.track[0].Duration
Write-Output $output.media.track[0].OverallBitRate
Write-Output $output.media.track[1].Format
Write-Output $output.media.track[1].Width
Write-Output $output.media.track[1].Height
Write-Output $output.media.track[1].Format
