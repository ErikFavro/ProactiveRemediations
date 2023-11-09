$Feature = "MicrosoftWindowsPowerShellV2Root"
$FeatureState = "Disabled"

Try{
    $PowerShell2 = Get-WindowsOptionalFeature -Online -FeatureName $Feature
    If ($FeatureState -eq $PowerShell2.State){
        Write-Output "Compliant"
        Exit 0
    }
    Write-Warning "Not Compliant"
    Exit 1
}

Catch{
    Write-Warning "Not Compliant"
    Exit 1
}