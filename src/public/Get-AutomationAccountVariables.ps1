function Get-AutomationAccountVariables {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Variables
    )
    $ResultVariables = @{}
    foreach ($Variable in $Variables){
        $Value = Get-AutomationVariable -Name $Variable -ErrorAction SilentlyContinue
        if ($null -eq $Value) {
            Write-Error "Variable $Variable not found in Automation Account"
            exit 1
        }
        $ResultVariables.Add($Variable, $Value)
    }
    $ResultVariables
}