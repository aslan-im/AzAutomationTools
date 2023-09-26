### --- PUBLIC FUNCTIONS --- ###
#Region - Get-AutomationAccountVariables.ps1
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
Export-ModuleMember -Function Get-AutomationAccountVariables
#EndRegion - Get-AutomationAccountVariables.ps1
#Region - Write-Log.ps1
function Write-Log {

    [CmdletBinding()]
    Param (
        
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias("LogContent")]
        [string]$Message,
        
        [Parameter(Mandatory = $false)]
        [ValidateSet("Error", "Warn", "Info")]
        [string]$Level = "Info",
        
        [Parameter(Mandatory = $false)]
        [switch]$NoClobber
    
    )
    
    Begin {
        $FormattedDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    }
    Process {

        switch ($Level) {
            'Error' {
                $LevelText = 'ERROR:'
                Write-Error "$FormattedDate $LevelText $Message"
            }
            'Warn' {
                $LevelText = 'WARNING:'
                Write-Warning "$FormattedDate $LevelText $Message"
            }
            'Info' {
                $LevelText = 'INFO:'
                Write-Output "$FormattedDate $LevelText $Message"
            }
        }
        
    }
}
Export-ModuleMember -Function Write-Log
#EndRegion - Write-Log.ps1
### --- PRIVATE FUNCTIONS --- ###
