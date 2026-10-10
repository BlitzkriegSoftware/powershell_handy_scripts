function Find-GitRepositoryRoot {
    param (
        [Parameter(Mandatory = $true)]
        [string]$FilePath
    )

    [string]$herePath = $FilePath
    [bool]$isFile = Test-Path -Path $herePath -PathType Leaf
    # Write-Output "${herePath}: Is Leaf: $isFile"
    if ($isFile) {
        $herePath = (Get-Item $FilePath).DirectoryName
    }
    
    while (($null -ne $herePath) -and ($herePath.Length -gt 0)) {
        [string]$lookFor = Join-Path -Path $herePath -ChildPath ".git"
        # Write-Output "HP: ${herePath}, LF: ${lookFor}"
        if (Test-Path $lookFor -PathType Container) {
            return $herePath
        }
        $herePath = (Get-Item $herePath).Parent.FullName
    }

    Write-Warning "${FilePath}: No Git repository found in the path or its parent directories."
    return $null
}