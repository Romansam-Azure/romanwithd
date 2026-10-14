# scripts/deploy-wdp.ps1
param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,
    [Parameter(Mandatory=$true)]
    [string]$ConfigFilePath,
    [Parameter(Mandatory=$true)]
    [string]$KeyVaultName
)

# Read configuration
$config = Get-Content -Path $ConfigFilePath | ConvertFrom-Json
$msdeployPackageUrls = $config.msdeploy_package_urls
$deployExmDds = $config.deploy_exm_dds

# Authenticate with Azure (assumes pipeline has logged in)
# az login --service-principal --username $env:AZURE_CLIENT_ID --password $env:AZURE_CLIENT_SECRET --tenant $env:AZURE_TENANT_ID

# Deploy WDPs for Sitecore roles
$roles = @("si", "cm", "cd", "prc")
foreach ($role in $roles) {
    if ($msdeployPackageUrls.$role) {
        Write-Host "Deploying WDP for role: $role"
        $appName = "sitecorexp104-uat-$role"
        az webapp deployment source config-zip --resource-group $ResourceGroupName --name $appName --src $msdeployPackageUrls.$role
        if ($LASTEXITCODE -ne 0) {
            Write-Error "Failed to deploy WDP for $role"
            exit 1
        }
    }
}

# Deploy SXA for CM and CD
if ($msdeployPackageUrls.sxa_cm) {
    Write-Host "Deploying SXA WDP for CM"
    az webapp deployment source config-zip --resource-group $ResourceGroupName --name "sitecorexp104-uat-cm" --src $msdeployPackageUrls.sxa_cm
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to deploy SXA WDP for CM"
        exit 1
    }
}
if ($msdeployPackageUrls.sxa_cd) {
    Write-Host "Deploying SXA WDP for CD"
    az webapp deployment source config-zip --resource-group $ResourceGroupName --name "sitecorexp104-uat-cd" --src $msdeployPackageUrls.sxa_cd
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to deploy SXA WDP for CD"
        exit 1
    }
}

# Deploy PowerShell Extensions for CM
if ($msdeployPackageUrls.powershell) {
    Write-Host "Deploying PowerShell Extensions WDP for CM"
    az webapp deployment source config-zip --resource-group $ResourceGroupName --name "sitecorexp104-uat-cm" --src $msdeployPackageUrls.powershell
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to deploy PowerShell Extensions WDP"
        exit 1
    }
}

# Deploy WDPs for XConnect services
$xconnectServices = @("ref_data", "collect", "search", "ma_ops", "ma_rep", "cortex_processing", "cortex_reporting")
foreach ($service in $xconnectServices) {
    if ($msdeployPackageUrls.$service) {
        Write-Host "Deploying WDP for XConnect service: $service"
        $appName = "sitecorexp104-uat-xc-$service"
        az webapp deployment source config-zip --resource-group $ResourceGroupName --name $appName --src $msdeployPackageUrls.$service
        if ($LASTEXITCODE -ne 0) {
            Write-Error "Failed to deploy WDP for $service"
            exit 1
        }
    }
}

# Deploy EXM for CM (if applicable)
if ($msdeployPackageUrls.exm_cm -and $deployExmDds) {
    Write-Host "Deploying EXM WDP for CM"
    az webapp deployment source config-zip --resource-group $ResourceGroupName --name "sitecorexp104-uat-cm" --src $msdeployPackageUrls.exm_cm
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to deploy EXM WDP"
        exit 1
    }
}

# Deploy DDS (if applicable)
if ($msdeployPackageUrls.dds -and $deployExmDds) {
    Write-Host "Deploying DDS WDP"
    az webapp deployment source config-zip --resource-group $ResourceGroupName --name "sitecorexp104-uat-exm-dds" --src $msdeployPackageUrls.dds
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to deploy DDS WDP"
        exit 1
    }
}

Write-Host "WDP deployment completed successfully"