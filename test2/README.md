# Terraform VM accelerator

This is an accelerator based on the Datacom CPS solution accelerator for virtual machines using an existing subnet.

## Usage

Clone this repository, create a separate repository/project for each set of related VMs

* Create an folder for the yaml vm configurations e.g. `./environments/dev/`
* Create an environment configuration e.g. `./environments/dev/dev.terraform.tfvars`
* Create the pipeline variables `./pipelines/variables/dev.vars.yaml`
* Create the pipelines `./pipelines/deploy-dev.yaml`

Edit tfvars and add any additional resources

Requires:

* virtual network subnet
* core resource group with terraform state storage account and key vault
* resource group for resources separate from the core resource group

### Specifying the virtual machines

Create yaml configuration files for creation of vms. Each file represents a set of configurations that match one or more vms.

Each file can only be for one OS Type. Everything in the configuration file will be applied for the vms listed. These can be listed in two ways. With a fixed list and/or a set of rules to generate a list of vms.

```yaml

## fixed list is done using the vms map as follows.
##The sku size is optional. If not specified the global sku size is used instead
vms:
  vm01:
    name: "LAB01DAZ"
    private_ip_address: "10.10.128.5"
  vm02:
    name: "LAB02DAZ"
    private_ip_address: "10.10.128.6"
    sku_size: "Standard_D2as_v5"

##The generator specification uses a naming pattern and a counter to increment.
## In this example the %02d is a 2 digit representation of the vm counter. The start is the inital number used and the vm count specifies the number of vms to generate
## The counter is also used to replace the %d in the private ip format starting with the ip_start value
## So the below expands to LAB02DAZ with 10.255.0.5 and LAB03DAZ with 10.255.0.6
## To add an additional vm just change the vm_count from 2 to 3. Or however many vms are required.
vm_name_pattern: "LAB%02dDAZ"
vm_count_start: 2
vm_count: 2
ip_format: "10.255.0.%d"
ip_start: 5

```

Example:

```yaml
os_type: "Windows"  ## Windows or Linux

## If more than one resource group will be used for the deploy then create a yaml file for each one
resource_group_name: rg-stutest-vm-dev-ae-01
location: australiaeast

## If more than one subnet will be used for the deploy then create a yaml file for each one
virtual_network: vnet-stutest-dev-ae-01
subnet: snet-stutest-vm-dev-ae-01

admin_username: myadmin

## Global Sku size will be used for all vms unless overriden in the vms map. If using the generator vm config then this is the sku size used.
sku_size: "Standard_B2als_v2"
license_type: "Windows_Server" ## For hybrid licence

## Fixed list of vms to create
vms:
  vm01:
    name: "LAB01DAZ"
    private_ip_address: "10.10.128.5"
  vm02:
    name: "LAB02DAZ"
    private_ip_address: "10.10.128.6"
    sku_size: "Standard_D2as_v5"

## Operating system disk
os_disk:
  storage_account_type: "StandardSSD_LRS"
  caching: "ReadWrite"

## Map of data disks
data_disk_managed_disks:
  disk1:
    name_suffix: "datadisk-01"
    storage_account_type: "StandardSSD_LRS"
    lun: 0
    caching: "ReadWrite"
    disk_size_gb: 32

## Source image
source_image_reference:
  publisher: "MicrosoftWindowsServer"
  offer: "WindowsServer"
  sku: "2022-datacenter-g2"
  version: "latest"

## Tags specific to the VM
tags:
  AutoStartStopEnable: true,
  AutoStartStopConfig: "{ IgnoreWeekends: 'false', StartHour: '08', StopHour: '10' }"
  backup: "Start2amRetain28Days"
```

## Finding source images

The following can find potential source images (SKUs)

```powershell
# find publishers
Get-AzVMImagePublisher -location "AustraliaEast" | where PublisherName -like "MicrosoftWindows*"
Get-AzVMImagePublisher -location "AustraliaEast" | where PublisherName -like "Canonical"
# find available offers
Get-AzVMImageOffer -location "AustraliaEast" -publishername "Canonical"
# find SKUs in each offer
Get-AzVMImageSku -location "AustraliaEast" -publishername "Canonical" -offer "ubuntu-24_04-lts"
```

Use Azure CLI to get the available images

Export to CSV

```
az login --use-device-code
$images_raw = [string](az vm image list --all --location australiaeast --publisher 'MicrosoftWindows')
$images = ConvertFrom-Json $images_raw
$images | Export-Csv -path c:\temp\vm-imgages.csv
```

Specific image versions

```
az vm image list --all --location australiaeast --publisher 'MicrosoftSQLServer' --offer 'sql2022-ws2022' --sku 'sqldev-gen2'
```

If using a marketplace image that has terms to accept, this needs to be done once per subscription. And the plan must be added to the yaml configuration.

```
az vm image terms accept --urn publisher:offer:sku:version
```

[Azure CLI ref](https://learn.microsoft.com/en-us/cli/azure/vm/image/terms?view=azure-cli-latest)

```
az vm image terms accept --urn center-for-internet-security-inc:cis-rhel:cis-redhat9-l1-gen2:latest

source_image_reference:
  publisher: "center-for-internet-security-inc"
  offer: "cis-rhel"
  sku: "cis-redhat9-l1-gen2"
  version: "latest"

plan:
  name: "cis-redhat9-l1-gen2"
  publisher: "center-for-internet-security-inc"
  product: "cis-rhel"

```

## alternatives

```terraform
    # alternatively, specify a subnet
    #
    #vnet_name: "stutest-vnet-dev-ae-01"
    #subnet_name: "snet-stutest-vm-dev-ae-01"
    #private_ip_address: "10.10.128.133"
    #
    # & optionally
    #
    #vnet_rg: "rg-stutest-vm-dev-ae-01"
```
