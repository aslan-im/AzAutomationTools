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