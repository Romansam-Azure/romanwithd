resource "azurerm_policy_definition" "require_multiple_tags" {
  name         = "custom-require-multiple-tags"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Require multiple tags and their values on resources"
  description  = "Enforces multiple required tags and their values. Does not apply to resource groups."

  metadata = jsonencode({
    version  = "1.0.2"
    category = "Tags"
  })

  parameters = jsonencode({
    tagNames = {
      type = "Array",
      metadata = {
        displayName = "Tag Names"
        description = "List of tag names that should be present on the resource."
      }
    },
    tagValues = {
      type = "Array",
      metadata = {
        displayName = "Tag Values"
        description = "List of tag values corresponding to the tag names."
      }
    }
  })

  policy_rule = jsonencode({
    if = {
      anyOf = [
        {
          allOf = [
            {
              field = "[concat('tags[', parameters('tagNames')[0], ']')]"
              notEquals = "[parameters('tagValues')[0]]"
            }
          ]
        },
        {
          allOf = [
            {
              field = "[concat('tags[', parameters('tagNames')[1], ']')]"
              notEquals = "[parameters('tagValues')[1]]"
            }
          ]
        },
        {
          allOf = [
            {
              field = "[concat('tags[', parameters('tagNames')[2], ']')]"
              notEquals = "[parameters('tagValues')[2]]"
            }
          ]
        }
      ]
    }
    then = {
      effect = "deny"
    }
  })
}

resource "azurerm_subscription_policy_assignment" "assign_require_multiple_tags" {
  name                 = "require-multiple-tags-assignment"
  display_name         = "Require Multiple Tags Assignment"
  policy_definition_id = azurerm_policy_definition.require_multiple_tags.id
  subscription_id      = var.policy_scope  # Define the scope (subscription, resource group, etc.)
  location             = "Australia East"

  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    tagNames = {
      value = ["Sub", "Monitor", "Owner"]
    },
    tagValues = {
      value = ["Prod", "Yes", "JohnDoe"]
    }
  })
}
