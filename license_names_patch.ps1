$2200Dir = "C:\Program Files\ModifiableWindowsApps\Football Manager 2022\data\database\db\2200"
$2201Dir = "C:\Program Files\ModifiableWindowsApps\Football Manager 2022\data\database\db\2201"
$2210Dir = "C:\Program Files\ModifiableWindowsApps\Football Manager 2022\data\database\db\2210"

$foldersToPatch = @("dbc", "edt", "Inc")

$editorDataDir = [environment]::getfolderpath("mydocuments")+"\Sports Interactive\Football Manager 2022\editor data"
$editorDataPatch = Get-ChildItem "patch_files/editor data"

$patchDir = Get-ChildItem "patch_files"

$instalationDir = @($2200Dir,$2201Dir,$2210Dir)

# Delete folders
foreach ($dir in $instalationDir) {
    if ($dir.BaseName -in $foldersToPatch) {
        Remove-Item -LiteralPath $dir -Force -Recurse
        New-Item -ItemType directory -Path $dir
    }
}

# Copy folders
foreach ($folder in $instalationDir) {
    foreach ($patch in $patchDir) {
        if ($patch.BaseName -ne "editor data") {
            Copy-Item -Path $patch -Destination $folder -Recurse -Force
        }
    }   
}

Copy-Item $editorDataPatch -Destination $editorDataDir -Recurse -force
