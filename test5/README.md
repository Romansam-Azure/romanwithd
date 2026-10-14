# Introduction 
This Git repository contains the Terraform modules used to create and manage the Azure MVC

# Structure

```
├── modules
│   ├── mgmtGroups
│   ├── resourceGroups
|   ├── policyAssignments
|   ├── logAnalytics
├── ci
│   ├── terraform-apply.yaml
│   ├── terraform-plan.yaml
│   ├── terraform-destroy.yaml
├── backend.tf
├── project.tf
├── providers.tf
├── variables.tf
├── versions.tf
```

* **modules** folder are the key ingredient to writing reusable, maintainable, and testable Terraform code, we structure the subfolder from the each services(resourceGroups, ManagementGroups etc.) level.
* **ci** folder for Azure Devops YAML files.
* **backend.tf** store the state of the current resources.
* **project.tf** inside manifests define the module that want to apply(execute).
* **providers.tf** containers the providers used for modules, eg. Azure is a provider.
* **variables.tf** the definition of all the variables.
* **versions** defines the Terraform version that must be used.

