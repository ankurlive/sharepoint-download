# ================= CONFIG =================
$tenantId     = "xxxxx"
$clientId     = "xxxxx"
$clientSecret = "xxxxx"

$siteUrl   = "https://example.sharepoint.com/sites/sample"
$folderPath = "/directory"

$downloadPath = "D:\items"
# ==========================================

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

if (!(Test-Path $downloadPath)) {
    New-Item -ItemType Directory -Path $downloadPath | Out-Null
}

# ================= AUTH =================
function Get-AccessToken {

    $body = @{
        client_id     = $clientId
        scope         = "https://graph.microsoft.com/.default"
        client_secret = $clientSecret
        grant_type    = "client_credentials"
    }

    $response = Invoke-RestMethod -Method POST `
        -Uri "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token" `
        -ContentType "application/x-www-form-urlencoded" `
        -Body $body

    return $response.access_token
}

$accessToken = Get-AccessToken

$headers = @{
    Authorization = "Bearer $accessToken"
}

# ================= GET SITE =================
$uri = [System.Uri]$siteUrl
$siteHost = $uri.Host
$sitePath = $uri.AbsolutePath

$siteApi = "https://graph.microsoft.com/v1.0/sites/{0}:{1}" -f $siteHost, $sitePath
$site = Invoke-RestMethod -Headers $headers -Uri $siteApi
$siteId = $site.id

# ================= GET DRIVE =================
$driveApi = "https://graph.microsoft.com/v1.0/sites/{0}/drive" -f $siteId
$drive = Invoke-RestMethod -Headers $headers -Uri $driveApi
$driveId = $drive.id

# ================= GET FILES =================
$encodedPath = [uri]::EscapeDataString($folderPath) -replace "%2F","/"
$filesUrl = "https://graph.microsoft.com/v1.0/drives/{0}/root:{1}:/children" -f $driveId, $encodedPath

$files = Invoke-RestMethod -Uri $filesUrl -Headers $headers

# ================= DOWNLOAD =================
foreach ($file in $files.value) {

    if ($file.file) {

        $fileName = $file.name
        $fileId   = $file.id
        $localPath = Join-Path $downloadPath $fileName

        Write-Host "Downloading: $fileName"

        $contentUrl = "https://graph.microsoft.com/v1.0/drives/{0}/items/{1}/content" -f $driveId, $fileId

        try {
            # THIS IS THE KEY FIX
            Invoke-RestMethod -Uri $contentUrl -Headers $headers -OutFile $localPath
            Write-Host "Downloaded: $fileName"
        }
        catch {
            Write-Warning "Failed: $fileName"
        }
    }
}

Write-Host "Download Completed!"
