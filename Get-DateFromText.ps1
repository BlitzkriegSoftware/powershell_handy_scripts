function Get-DateFromText {
    param (
        [string]$text,
        [datetime]$defaultValue = [System.DateTime]::MinValue
    )
    $value = $text -as [datetime]
    if ( $null -eq $value) {
        $value = $defaultValue
    } 
    return $value;
}
