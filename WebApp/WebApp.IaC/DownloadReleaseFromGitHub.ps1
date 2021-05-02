# Download latest dotnet/codeformatter release from github

$repo = "samsmithnz/WebAppDeploymentTest"
$filenamePattern = "webservice.zip"
$pathExtract = "C:\Users\samsmit\source\repos\Test"

$releasesUri = "https://api.github.com/repos/$repo/releases/latest"
$downloadUri = ((Invoke-RestMethod -Method GET -Uri $releasesUri).assets | Where-Object name -like $filenamePattern ).browser_download_url

$pathZip = Join-Path -Path $([System.IO.Path]::GetTempPath()) -ChildPath $(Split-Path -Path $downloadUri -Leaf)

Invoke-WebRequest -Uri $downloadUri -Out $pathZip

#Remove-Item -Path $pathExtract -Recurse -Force -ErrorAction SilentlyContinue

#$tempExtract = Join-Path -Path $([System.IO.Path]::GetTempPath()) -ChildPath $((New-Guid).Guid)
#Expand-Archive -Path $pathZip -DestinationPath $tempExtract -Force
#Move-Item -Path "$tempExtract\*" -Destination $pathExtract -Force
#Remove-Item -Path $tempExtract -Force -Recurse -ErrorAction SilentlyContinue

#Remove-Item $pathZip -Force

#Deploy web service 
$resourceGroupName="samwestus"
$serviceName="samweb-prod-wu-service"

#dotnet publish "C:\Users\samsmit\source\repos\DevOpsMetrics\src\DevOpsMetrics.Service\DevOpsMetrics.Service.csproj" --configuration Debug --self-contained --runtime win-x86 --output "C:\Users\samsmit\source\repos\DevOpsMetrics\src\DevOpsMetrics.Service\bin\webservice" 
#Compress-Archive -Path "C:\Users\samsmit\source\repos\DevOpsMetrics\src\DevOpsMetrics.Service\bin\webservice\*.*" -DestinationPath "C:\Users\samsmit\source\repos\DevOpsMetrics\src\DevOpsMetrics.Service\bin\webservice.zip" -Force
az webapp deployment source config-zip --resource-group $resourceGroupName --name $serviceName --src $pathZip
