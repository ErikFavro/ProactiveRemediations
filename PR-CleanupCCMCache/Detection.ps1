<#
.Synopsis
    Detects CCM Cache older than specified date
.DESCRIPTION
    Seaches all cache for older than specified days and returns true or false.  If a client has been repaired the older cache will 
    not remove since the new client doesn't know about it
.EXAMPLE
   
#>

#get CCMCache path
$Cachepath = ([wmi]"ROOT\ccm\SoftMgmtAgent:CacheConfig.ConfigKey='Cache'").Location

#Get Items not referenced for more than 30 days
$OldCache = get-wmiobject -query "SELECT * FROM CacheInfoEx" -namespace "ROOT\ccm\SoftMgmtAgent" | Where-Object { ([datetime](Date) - ([System.Management.ManagementDateTimeConverter]::ToDateTime($_.LastReferenced))).Days -gt 30  }

#report old Items
if($OldCache) { $false } else { $true } 