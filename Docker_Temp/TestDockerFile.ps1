[CmdletBinding()]
      param (
	 [parameter(mandatory=$true)]$USERNAME,
	[parameter(mandatory=$true)] $GROUP,
	[parameter(mandatory=$true)]$DLLNAME
)
Remove-Item $env:temp\Kube-Generate -Confirm:$true 
New-Item $env:temp\Kube-Generate -type Directory
$sourceurl = "https://raw.githubusercontent.com/avinash-chellapandian/Template/master/Docker_Temp/Test.txt"
$destpath = "$env:temp\Kube-Generate\Tempalate.txt"
Invoke-WebRequest -Uri $sourceurl -OutFile $destpath
$content = (Get-Content -Path $env:temp\Kube-Generate\Tempalate.txt).Replace('$USERNAME',"$USERNAME").Replace('$GROUP',"$GROUP").Replace('$DLLNAME',"$DLLNAME").Replace('$Timestamp',$(Get-Date -Format F) +" "+'Version: 01')
Remove-Item .\Deployment_new\ -Confirm:$true
New-Item .\Deployment_new\ -ItemType Directory
$content | Out-File -FilePath .\Deployment_new\Dockerfile
