<#
  Parse a semantic version string for the major version
#>
function Get-MajorVersion([string]$version) {
    [int]$major = 0;
    if (-not [string]::IsNullOrWhiteSpace($version)) {
        [int]$index = $version.IndexOf('.');
        if ($index -gt 0) {
            [string]$t = $version.Substring(0, $index ).ToLower().Trim();
            $t = $t.Replace('v', '');
            $major = [System.Convert]::ToInt32($t);
        }
    }
    return $major;
}