# Download latest dotnet/codeformatter release from github

$repo = "samsmithnz/WebAppDeploymentTest"
$filenamePattern = "webservice.zip"
$pathExtract = "C:\Users\samsmit\source\repos\Test"


$releasesUri = "https://api.github.com/repos/$repo/releases/latest"
$downloadUri = ((Invoke-RestMethod -Method GET -Uri $releasesUri).assets | Where-Object name -like $filenamePattern ).browser_download_url

$pathZip = Join-Path -Path $([System.IO.Path]::GetTempPath()) -ChildPath $(Split-Path -Path $downloadUri -Leaf)

Invoke-WebRequest -Uri $downloadUri -Out $pathZip

Remove-Item -Path $pathExtract -Recurse -Force -ErrorAction SilentlyContinue

$tempExtract = Join-Path -Path $([System.IO.Path]::GetTempPath()) -ChildPath $((New-Guid).Guid)
Expand-Archive -Path $pathZip -DestinationPath $tempExtract -Force
Move-Item -Path "$tempExtract\*" -Destination $pathExtract -Force
Remove-Item -Path $tempExtract -Force -Recurse -ErrorAction SilentlyContinue

Remove-Item $pathZip -Force