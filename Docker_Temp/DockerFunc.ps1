function TestDockerFile {

[CmdletBinding()]
      param (
      [parameter(mandatory=$true)]$DOTNETVERSION,
	 [parameter(mandatory=$true)]$USERNAME,
	[parameter(mandatory=$true)] $GROUP,
	[parameter(mandatory=$true)]$DLLNAME
)
Remove-Item $env:temp\Kube-Generate -Confirm:$true 
New-Item $env:temp\Kube-Generate -type Directory
$sourceurl = "https://raw.githubusercontent.com/avinash-chellapandian/Template/master/Docker_Temp/Test.txt"
$destpath = "$env:temp\Kube-Generate\Tempalate.txt"
Invoke-WebRequest -Uri $sourceurl -OutFile $destpath
$content = (Get-Content -Path $env:temp\Kube-Generate\Tempalate.txt).Replace('$DOTNETVERSION',"$DOTNETVERSION").Replace('$USERNAME',"$USERNAME").Replace('$GROUP',"$GROUP").Replace('$DLLNAME',"$DLLNAME").Replace('$Timestamp',$(Get-Date -Format F) +" "+'Version: 01')
Remove-Item .\Deployment\ -Confirm:$true
New-Item .\Deployment\ -ItemType Directory
$content | Out-File -FilePath .\Deployment\Dockerfile

}
