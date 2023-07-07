## Thank you ChatGPT!
## Delete empty directories that have no file or sub-directory. Setting $forReal to false will only output list of folders taht will be deleted. 

$forReal = $True

# Specify the path to the parent directory containing the empty folders
$parentDirectory = "C:\Path\To\Parent\Directory"

# Get a list of all empty folders within the parent directory
$emptyFolders = Get-ChildItem -Path $parentDirectory -Directory -Recurse | Where-Object { $_.GetFiles().Count -eq 0 -and $_.GetDirectories().Count -eq 0 }

if ($forReal) {
    # Delete each empty folder
    $emptyFolders | ForEach-Object {
        $folderPath = $_.FullName
        Write-Output "Deleting empty folder: $folderPath"
        Remove-Item -Path $folderPath -Force -Recurse
}} else {
    Write-Host($emptyFolders -join ", ")    
}
