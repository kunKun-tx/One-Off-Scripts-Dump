## Ref: https://stackoverflow.com/questions/65564448/how-to-move-folders-into-subfolders-with-name-of-first-character-of-the-folder-t
## This script moves folders to another folder named with the first character of current folder

#Install-Module SplitPipeline
Import-Module SplitPipeline #this thing is amazing!

$forReal = $True
$workDirBase = "D:\MTVTEMP"
$wildcard = "" # use "??*" to filter folders with a two characters + name
$workDir = Join-Path -Path $workDirBase -ChildPath $wildcard
$destDir = "D:\MTVs"
$maxConcurrentJobs = 20

if (!$forReal) {
    Get-ChildItem -Path $workDir -Directory | ForEach-Object {
        Write-Host $_.FullName" will be moved to " (Join-Path $destDir $_.Name[0])
    }
}
else {
    Get-ChildItem -Path $workDir -Directory | Split-Pipeline -Count $maxConcurrentJobs -Variable destDir { process {
            # add empty folder check?
            $sourcePath = $_.FullName

            $destPath = Join-Path $destDir -ChildPath $_.Name[0] | Join-Path  -ChildPath $_.Name

            if (-not (Test-Path -Path $destPath)) {
                New-Item -Path $destPath -ItemType Directory | Out-Null
            }
   
            Write-Host $sourcePath "- -> " $destPath`n
            # Robocopy help us merge folders and files at dest, and you can still verify extra (duplicated) files from source
            # robocopy $sourcePath $destPath /E /MOVE /NFL /NDL #disabled for using Start-Process       
            #we wait it here so it won't spam a hundred robocopy instances, but somehow this is not very reliable. So re-enable regular robocopy to move those stubbon files
            #Start-Process -FilePath "robocopy.exe" -ArgumentList "$sourcePath $destPath /E /MOVE /NFL /NDL" -Wait 

        } }
}
