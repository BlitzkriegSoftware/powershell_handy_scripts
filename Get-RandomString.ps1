function Get-RandomString() {
    param (
        [int]$rLength = 16
    )
    $randomString = [Convert]::ToBase64String((1..$rLength | ForEach-Object { [byte](Get-Random -Max 256) }))

    return $randomString;
}

# Example:
# Get-RandomString -rLength 32