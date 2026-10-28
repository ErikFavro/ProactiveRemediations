$ServiceToFind = "ccmsetup"

if (Get-Service -Name $ServiceToFind -ErrorAction Ignore -WarningAction Ignore -InformationAction Ignore -Verbose){
    write-host "Service exists.  Audit ccmsetup.log for last exit code"
    
    $LastExitLine = Get-Content -Path "$env:windir\ccmsetup\Logs\ccmsetup.log" -Tail 1
    
    if ($LastExitLine -like "*CcmSetup failed with error code*"){
        Write-Host $LastExitLine
        If ("$env:windir\CCMSetup\ccmsetup.exe"){
            Write-Host "ccmsetup.exe exists, running remediation"
            Exit 1
        }
        Else{
            write-host "Missing ccmsetup.exe, unable to remediate"
            Exit 0
        }
    }
    Else{
        Write-Host "Compliant - ccmsetup service exists and is installing now"
        Exit 0
    }
}
else{
    Write-Host "Compliant"
    Exit 0
}