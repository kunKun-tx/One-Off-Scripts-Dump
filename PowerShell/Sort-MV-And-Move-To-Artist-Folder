# Special thanks to ChatGPT
# Sort all songs (with structured filename) in a folder by artist and move all songs of an artist to their own folder at dest. 

# Specify the source folder path
$sourceFolder = "E:\MTV\new"
# Specify the destination folder path
$destinationFolder = "D:\MTVTEMP"

# Specify the regex pattern to extract the desired part of the filename
#$pattern = "-(.+?)-" # Example pattern for song name from format "artist-song-language-genre"
#$pattern = "^([^-\s]+)" # Example pattern for artist name from format "artist-song-language-genre"
$pattern = "^([^-]+)" # Example pattern for artist name from format "artist-song-language-genre"


# Get all files in the source folder
$files = Get-ChildItem -Path $sourceFolder -File

# Iterate through each file
foreach ($file in $files) {
    # Extract song name from 
    $artistName = [regex]::Match($file.Name, $pattern).Groups[1].Value
    #Write-Host $artistName

    if ($artistName.Length.Equals(0)) {
        Write-Host "regex pattern failed on " $files
        break
    }

    # Create the destination folder using the extracted part of the filename
    $destinationSubfolder = Join-Path -Path $destinationFolder -ChildPath $artistName
    if (-not (Test-Path -Path $destinationSubfolder)) {
        New-Item -Path $destinationSubfolder -ItemType Directory | Out-Null
    }

    # Move the file to the destination folder
    $destinationPath = Join-Path -Path $destinationSubfolder -ChildPath $file.Name
    Write-Host $file.FullName " -> " $destinationPath
    #Move-Item -Path $file.FullName -Destination $destinationPath -Force
    robocopy $file.Directory $destinationSubfolder $file.Name /E /MOVE /NFL /NDL
}
