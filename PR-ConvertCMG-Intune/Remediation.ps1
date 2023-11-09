$Path = "HKLM:\SOFTWARE\Microsoft\CCM"
$Name = "CMGFQDNs"
$Type = "STRING"
$Value = "CMG Name Goes Here"
$CCMExecExists = "$env:windir\CCM\CCMExec.exe"
$CCMSetupExists = "$env:windir\CCMSetup\CCMSetup.exe"
$CheckPath = ""

If (!(Test-Path $CCMExecExists)){
    Try {
        If (Test-Path $CCMSetupExists){
            
            Start-Process -FilePath "$env:windir\CCMSetup\ccmsetup.exe" -ArgumentList "SMSSITECODE=XXX SMSMP=MP-Goes-here FSP=FSP-Goes-Here CCMHOSTNAME=CMG-NAME-GOES-HERE AADTENANTID=AAD-ID-GOES-HERE SMSCACHESIZE=25600" -Wait
        }
    }
    
    Catch
    {
        Write-Warning "Not Compliant"
        Exit 1
    }
}

If (!(Test-Path $Path)){
    New-ItemProperty -Path $Path -Name $Name -Force
}

$CheckPath = Get-ItemProperty -Path $Path -Name $Name -ErrorAction Stop | Select-Object -ExpandProperty $Name

If (!($CheckPath -eq $Value)){
    Set-ItemProperty -Path $Path -Name $Name -Type $Type -Value $Value -Force
    Restart-Service CCMEXEC -Force -Verbose
}