$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
$Name = "UseUpdateClassPolicySource"


Try {
    $Registry = Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue 
    If (!$Registry) {
        Write-Output "Compliant"
        Exit 0
    }
    Write-Warning "Not Compliant"
    Exit 1
} 
Catch {
    Write-Warning "Not Compliant"
    Exit 1
}