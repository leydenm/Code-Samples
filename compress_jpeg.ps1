#This creates dialog to to feed to MozJpeg
#written by Mike Leyden
Function Get-FileName($initialDirectory)
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "JPEG (*.jpg)| *.jpg"
    $Show = $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.filename
}

$inputfile = Get-FileName "%USERPROFILE%\"
if ($inputfile)
{
    $NewName = $inputfile -replace ".jpg$", "_moz.jpg"
    $command= "./cjpeg-static.exe -quality 80 " + " -outfile `"" + $NewName + "`" `""  + $inputfile + "`""
    iex $command
}
