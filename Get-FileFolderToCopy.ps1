#Based this script off of this article: https://workingsysadmin.com/open-file-dialog-box-in-powershell/
Function Get-FileFolderToCopy($FileOrFolder)
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

    If ($FileOrFolder -eq "File")
    {
        $OpenSelector = New-Object System.Windows.Forms.OpenFileDialog
        $OpenSelector.InitialDirectory = $initialDirectory
        $OpenSelector.ShowDialog() | Out-Null
        Return $OpenSelector.FileName
    }
    elseif ($FileOrFolder -eq "Folder")
    {
        $OpenFolderDialog = New-Object System.Windows.Forms.FolderBrowserDialog
        $SelectionsDone = $false

        Do{
            If ($OpenFolderDialog.ShowDialog() -eq "OK")
            {
                $OpenFolderDialog.SelectedPath
            }
            else
            {
                $SelectionsDone = $true
                Write-Output "Cancel"
            }
        } While ($SelectionsDone -eq $false)
    }
    else
    {
        Write-Error "Please specify File or Folder"
    }
}
