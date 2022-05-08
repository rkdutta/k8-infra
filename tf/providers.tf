terraform {

  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.4.0"
    }
    flux = {
      source  = "fluxcd/flux"
      version = "0.14.1"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "flux" {
  # Configuration options
}