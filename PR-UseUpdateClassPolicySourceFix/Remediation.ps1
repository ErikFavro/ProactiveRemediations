$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
$Name = "UseUpdateClassPolicySource"

Get-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU -Name UseUpdateClassPolicySource | Remove-ItemProperty -Name UseUpdateClassPolicySource -Force -Confirm:$false
Remove-Item "$env:windir\system32\GroupPolicy\Machine\Registry.pol" -Force -Confirm:$false

Restart-Service CCMExec -Force -Confirm:$false 