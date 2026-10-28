$ServiceToFind = "ccmexec"

#Stop WMI Services for forced client reinstall.  If ConfigMgr detects bad WMI it rebuilds client in full
Stop-Service Winmgmt -Force
Remove-Item -Path "$env:windir\system32\wbem\Repository" -Recurse -Force -Confirm:$false -ErrorAction Stop -Verbose

#If service is running for some reason stop it
If (Get-Service $ServiceToFind){
    Stop-Service $ServiceToFind -Force
}

#Start Service so it can detect fault and repair
Start-Process -FilePath "$env:windir\CCMSetup\ccmsetup.exe" -ArgumentList "/nocrlcheck SMSSITECODE=WWU SMSMP=SCCMFE1.univ.dir.wwu.edu FSP=SCCMFE1.univ.dir.wwu.edu CCMHOSTNAME=WWUCMG.EIS.WWU.EDU/CCM_Proxy_MutualAuth/72057594037927941 AADTENANTID=dc46140c-e26f-43ef-b0ae-00f257f478ff SMSCACHESIZE=30720" -Wait -Verbose