#Requires -Version 5.1
#Requires -Modules @{ ModuleName = 'BuildHelpers'; ModuleVersion = '2.0.1' }
#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.2.0' }

$pesterConfig = New-PesterConfiguration -Hashtable @{
    Run    = @{
        Path                           = "$PSScriptRoot/.."
        PassThru                       = $true
        FailOnNullOrEmptyForEach       = $false
    }
    Output = @{
        Verbosity = 'Detailed'
    }
}
$result = Invoke-Pester -Configuration $pesterConfig
$failureCount = [int]$result.FailedCount + [int]$result.FailedContainersCount + [int]$result.FailedBlocksCount
if ($failureCount -gt 0) {
    throw "Pester reported $failureCount failure(s), including container/discovery failures."
}
exit 0
