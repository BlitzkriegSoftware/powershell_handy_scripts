Function Touch-File {
    $filename = $args[0]
    if ([string]::IsNullOrWhitespace($filename)) {
        throw "No filename supplied"
    }

    if (Test-Path $filename) {
        (Get-ChildItem $filename).LastWriteTime = Get-Date
    }
    else {
        echo $null > $filename
    }
}

# Set-Alias -Name touch -Value Touch-File