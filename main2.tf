terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
  required_version = ">=1.0.0"
}

provider "azurerm" {
  subscription_id = "a91827c9-376e-4d61-b2f8-7523ae102f22"
  tenant_id       = "4f2bcdcd-3575-4ce3-b31b-c996949e18a8"
  features {}
}

resource "azurerm_resource_group" "web_rg" {
  name     = "WebServiceRG"
  location = "Central India"
}

resource "azurerm_service_plan" "Web_plan" {
  name                = "webPlan01"
  location            = azurerm_resource_group.web_rg.location
  resource_group_name = azurerm_resource_group.web_rg.name
  os_type             = "Windows"

  sku_name = "B1"

}
resource "azurerm_app_service" "web_app" {
  name                = "tusharabc"
  location            = azurerm_resource_group.web_rg.location
  resource_group_name = azurerm_resource_group.web_rg.name
  app_service_plan_id = azurerm_service_plan.Web_plan.id

  site_config {
    dotnet_framework_version = "v6.0" # Change to your preferred version
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "0"
  }

  https_only = true
}
