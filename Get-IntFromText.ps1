function Get-IntFromText {
    param (
        [string]$text,
        [int]$defaultValue = 0
    )
    $value = $text -as [int]
    if ( $null -eq $value) {
        $value = $defaultValue;
    } 
    return $value;
}