Function Get-FileFolderToCopy()
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

    $OpenSelector = New-Object System.Windows.Forms.OpenFileDialog
    $OpenSelector.ShowDialog() | Out-Null
    $OpenSelector.FileName
}
