function TestDockerFile {

[CmdletBinding()]
      param (
     [String] $DOTNETVERSION=$(Read-Host -prompt "Please enter the.NET Version as 3.1.7 or 2.1.21"),
	 [String]$USERNAME=$(Read-Host -prompt "Please enter the username of the Service"),
	[String]$GROUP=$(Read-Host -prompt "Please enter the Groupname of the Service"),
	[String]$DLLNAME=$(Read-Host -prompt "Please enter the .dll name")
)
Remove-Item $env:temp\Kube-Generate -Confirm:$true 
New-Item $env:temp\Kube-Generate -type Directory
$sourceurl = "https://raw.githubusercontent.com/avinash-chellapandian/Template/master/Docker_Temp/Dockerfile"
$destpath = "$env:temp\Kube-Generate\Dockerfile"
Invoke-WebRequest -Uri $sourceurl -OutFile $destpath
Remove-Item .\Deployment\ -Confirm:$true
New-Item .\Deployment\ -ItemType Directory
if($DOTNETVERSION -eq "3.1.7")
{
$content = (Get-Content -Path $env:temp\Kube-Generate\Dockerfile).Replace('$USERNAME',"$USERNAME").Replace('$IMAGETYPE',"3.1-bionic").Replace('$GROUP',"$GROUP").Replace('$DLLNAME',"$DLLNAME").Replace('$Timestamp',$(Get-Date -Format F) +" "+'Version: 01')

}
elseif ($DOTNETVERSION -eq "2.1.21") {
$content = (Get-Content -Path $env:temp\Kube-Generate\Dockerfile).Replace('$USERNAME',"$USERNAME").Replace('$IMAGETYPE',"2.1-bionic").Replace('$GROUP',"$GROUP").Replace('$DLLNAME',"$DLLNAME").Replace('$Timestamp',$(Get-Date -Format F) +" "+'Version: 01')

}
else {
$content = (Get-Content -Path $env:temp\Kube-Generate\Dockerfile).Replace('$USERNAME',"$USERNAME").Replace('$IMAGETYPE',"2.1-bionic").Replace('$GROUP',"$GROUP").Replace('$DLLNAME',"$DLLNAME").Replace('$Timestamp',$(Get-Date -Format F) +" "+'Version: 01')
}
$content | Out-File -encoding UTF8 -FilePath .\Deployment\Dockerfile
Write-Host "Dockerfile created $DOTNETVERSION"

}
