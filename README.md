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

---

**## 🔐 Permissions**

Microsoft Graph → **Application Permissions**

    Sites.Read.All
    Files.Read.All

👉 Grant **Admin Consent**

---

## 🧰 Dependencies

No external dependencies required.

Built-in PowerShell commands used:

    Invoke-RestMethod
    Invoke-WebRequest

### Requirements

    PowerShell 5.1+
    Internet access to Microsoft Graph & SharePoint

---
