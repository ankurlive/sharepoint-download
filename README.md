# 📦 SharePoint File Downloader (PowerShell)

## 🚀 Overview
This script downloads files from a SharePoint folder to your local machine using Microsoft Graph API with App Registration (no user login required).

---

## ⚙️ Configuration

Update these values in `download.ps1`:

```powershell
$tenantId     = "YOUR_TENANT_ID"
$clientId     = "YOUR_CLIENT_ID"
$clientSecret = "YOUR_CLIENT_SECRET"

$siteUrl    = "https://yourtenant.sharepoint.com/sites/sample"
$folderPath = "/directory"

$downloadPath = "D:\items"
