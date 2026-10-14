resource "azurerm_policy_definition" "tag_inher" {
  name         = "custom-policy-multiple-tags"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "EPS Inherit multiple tags from the resource group if missing"
  description  = "Adds the specified tags with their values from the parent resource group when any resource missing these tags is created or updated."

  policy_rule = <<POLICY_RULE
{
  "if": {
    "anyOf": [
      {
        "allOf": [
          {
            "field": "[concat('tags[', parameters('tag1Name'), ']')]",
            "exists": "false"
          },
          {
            "value": "[resourceGroup().tags[parameters('tag1Name')]]",
            "notEquals": ""
          }
        ]
      },
      {
        "allOf": [
          {
            "field": "[concat('tags[', parameters('tag2Name'), ']')]",
            "exists": "false"
          },
          {
            "value": "[resourceGroup().tags[parameters('tag2Name')]]",
            "notEquals": ""
          }
        ]
      },
      {
        "allOf": [
          {
            "field": "[concat('tags[', parameters('tag3Name'), ']')]",
            "exists": "false"
          },
          {
            "value": "[resourceGroup().tags[parameters('tag3Name')]]",
            "notEquals": ""
          }
        ]
      }
    ]
  },
  "then": {
    "effect": "modify",
    "details": {
      "roleDefinitionIds": [
        "/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"
      ],
      "operations": [
        {
          "operation": "add",
          "field": "[concat('tags[', parameters('tag1Name'), ']')]",
          "value": "[resourceGroup().tags[parameters('tag1Name')]]"
        },
        {
          "operation": "add",
          "field": "[concat('tags[', parameters('tag2Name'), ']')]",
          "value": "[resourceGroup().tags[parameters('tag2Name')]]"
        },
        {
          "operation": "add",
          "field": "[concat('tags[', parameters('tag3Name'), ']')]",
          "value": "[resourceGroup().tags[parameters('tag3Name')]]"
        }
      ]
    }
  }
}
POLICY_RULE

  parameters = <<PARAMETERS
{
  "tag1Name": {
    "type": "String",
    "metadata": {
      "displayName": "Tag 1 Name",
      "description": "Name of the first tag, such as 'environment'"
    }
  },
  "tag2Name": {
    "type": "String",
    "metadata": {
      "displayName": "Tag 2 Name",
      "description": "Name of the second tag, such as 'department'"
    }
  },
  "tag3Name": {
    "type": "String",
    "metadata": {
      "displayName": "Tag 3 Name",
      "description": "Name of the third tag, such as 'owner'"
    }
  }
}
PARAMETERS

  metadata = <<METADATA
{
  "category": "Tags",
  "version": "1.1.0"
}
METADATA
}


resource "azurerm_subscription_policy_assignment" "tags_inheritance" {
  name                 = "custom-policy-multiple-tags-assignment"
  subscription_id      = var.policy_scope
  policy_definition_id = azurerm_policy_definition.tag_inher.id
  display_name         = "EPS Inherit multiple tags from the resource group if missing"
  description          = "This policy assignment ensures resources inherit the specified tags from the resource group."
  location             = "Australia East"

  identity {
    type = "SystemAssigned"
  }

  parameters = <<PARAMETERS
{
  "tag1Name": {
    "value": "CostCenter"
  },
  "tag2Name": {
    "value": "Environment"
  },
  "tag3Name": {
    "value": "Deployment"
  }
}
PARAMETERS


}
