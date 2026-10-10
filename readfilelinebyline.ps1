<#
  Read a big file line by line (memory safe)
  Where $FilePath is path to the file
#>

$stream = $null;
try {
    $stream = [System.IO.StreamReader]::new($FilePath)
    while ($null -ne ($line = $stream.ReadLine())) {
        # Do something with a line
        Write-Output $line
    }
}
catch {
    $errMsg = $_.Exception.Message
    Write-Error "File Read Error: ${errMsg}"
    # Do we need to exit the process?
} 
finally {
    if ($stream) {
        $stream.Dispose()
    }
}