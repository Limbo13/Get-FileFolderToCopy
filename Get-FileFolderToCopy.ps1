<#
    .SYNOPSIS
    This script lets you choose a list of files or folders from a GUI interface.

    .DESCRIPTION
    This script lets you choose a list of files or folders from a GUI interface.  Variable takes "file" or "folder".

    When the command is run, a selection window appears letting you choose files or folders, depending on what you specify when calling the script.

    If you choose files, you can select multiple files at once from the same folder.  If you choose folders, you can select one, click OK, then choose another.
    This will repeat until Cancel is clicked.

    An array named $SelectedList is returned with the results.

    .EXAMPLE
    Get-FileFolderToCopy("File")

    .EXAMPLE
    Get-FileFolderToCopy("Folder")

    .EXAMPLE
    Get-FileFolderToCopy("Files")
#>
Function Get-FileFolderToCopy()
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [String]$FileOrFolder
        )

    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

    If ($FileOrFolder -like "File*")
    {
        $OpenSelector = New-Object System.Windows.Forms.OpenFileDialog
        $OpenSelector.InitialDirectory = $initialDirectory
        $OpenSelector.Multiselect = $true
        $OpenSelector.ShowDialog() | Out-Null
        $global:SelectedList = $OpenSelector.FileNames
    }
    elseif ($FileOrFolder -like "Folder*")
    {
        $OpenFolderDialog = New-Object System.Windows.Forms.FolderBrowserDialog
        $SelectionsDone = $false
        $global:SelectedList = @()

        Do{
            If ($OpenFolderDialog.ShowDialog() -eq "OK")
            {
                $global:SelectedList += $OpenFolderDialog.SelectedPath
            }
            else
            {
                $SelectionsDone = $true
            }
        } While ($SelectionsDone -eq $false)
    }
    else
    {
        Write-Error "Please specify File or Folder"
    }
}
