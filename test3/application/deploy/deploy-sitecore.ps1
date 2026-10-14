param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,
    [Parameter(Mandatory=$true)]
    [string]$WebAppName,
    [string]$SlotName,
    [Parameter(Mandatory=$true)]
    [string]$StorageAccountName,
    [Parameter(Mandatory=$true)]
    [string]$StorageContainerName,
    [Parameter(Mandatory=$true)]
    [string]$DeploymentId,
    [Parameter(Mandatory=$false)]
    [string]$LicenseFilePath = "",
    [Parameter(Mandatory=$true)]
    [string]$WdpBlobName,
    [Parameter(Mandatory=$true)]
    [string]$ClientId,
    [Parameter(Mandatory=$true)]
    [string]$TenantId
)

Import-Module Az.Accounts -ErrorAction Stop
Import-Module Az.Websites -ErrorAction Stop
Import-Module Az.Storage -ErrorAction Stop

try {
    # Authenticate using Workload Identity Federation
    Write-Output "Authenticating with Workload Identity Federation"
    $currentContext = Get-AzContext
    if (-not $currentContext) {
        $token = $env:SYSTEM_OIDCTOKEN
        if ($token) {
            Write-Output "Using SYSTEM_OIDCTOKEN for authentication"
            Connect-AzAccount -AccessToken $token -AccountId $ClientId -TenantId $TenantId -ErrorAction Stop
        } else {
            Write-Warning "SYSTEM_OIDCTOKEN not found, attempting authentication with managed identity"
            Connect-AzAccount -Identity -AccountId $ClientId -TenantId $TenantId -ErrorAction Stop
        }
    } else {
        Write-Output "Using existing authenticated context"
    }

    # Get storage context
    Write-Output "Creating storage context for account: $StorageAccountName"
    $storageContext = New-AzStorageContext -StorageAccountName $StorageAccountName -UseConnectedAccount -ErrorAction Stop

    # Download WDP
    $tempFilePath = Join-Path $env:TEMP "$($WdpBlobName)"
    Write-Output "Downloading WDP: $WdpBlobName to $tempFilePath"
    Get-AzStorageBlobContent -Container $StorageContainerName -Blob $WdpBlobName -Context $storageContext -Destination $tempFilePath -Force -ErrorAction Stop

    # Skip license file validation
    if (-not [string]::IsNullOrEmpty($LicenseFilePath) -and -not (Test-Path $LicenseFilePath -ErrorAction SilentlyContinue)) {
        Write-Warning "License file not found at $LicenseFilePath. Proceeding for testing purposes."
    } else {
        Write-Output "No license file validation performed (testing mode)."
    }

    # Deploy WDP
    $target = if ($SlotName) { "$WebAppName (Slot: $SlotName)" } else { $WebAppName }
    Write-Output "Deploying WDP to: $target"
    if ($SlotName) {
        Publish-AzWebApp -ResourceGroupName $ResourceGroupName -Name $WebAppName -SlotName $SlotName -ArchivePath $tempFilePath -Force -ErrorAction Stop
    } else {
        Publish-AzWebApp -ResourceGroupName $ResourceGroupName -Name $WebAppName -ArchivePath $tempFilePath -Force -ErrorAction Stop
    }

    Write-Output "Deployment completed successfully for $target"
} catch {
    Write-Error "Deployment failed for $WebAppName (WDP: $WdpBlobName): $_"
    exit 1
} finally {
    if (-not [string]::IsNullOrEmpty($tempFilePath) -and (Test-Path $tempFilePath -ErrorAction SilentlyContinue)) {
        Remove-Item $tempFilePath -Force -ErrorAction SilentlyContinue
        Write-Output "Cleaned up temporary file: $tempFilePath"
    }
}