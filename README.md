## ⚙️ Configuration

Update these values in `download.ps1`:

```powershell
$tenantId     = "YOUR_TENANT_ID"
$clientId     = "YOUR_CLIENT_ID"
$clientSecret = "YOUR_CLIENT_SECRET"

$siteUrl    = "https://yourtenant.sharepoint.com/sites/sample"
$folderPath = "/directory"

$downloadPath = "D:\items"
```

---

## 🔐 Permissions (Keep Application and Delegated)

Microsoft Graph → **Application Permissions**

```
Sites.Read.All
Files.Read.All
```

👉 Grant **Admin Consent**

---

## 🧰 Dependencies

No external dependencies required.
Built-in PowerShell commands used:

```
Invoke-RestMethod
Invoke-WebRequest
```

### Requirements

```
PowerShell 5.1+
Internet access to Microsoft Graph & SharePoint
```
