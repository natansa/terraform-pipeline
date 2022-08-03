terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.15.1"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "4.23.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "storage_account_resource_group_state"
    storage_account_name = "natanstorageaccountstate"
    container_name       = "remote-state"
    key                  = "pipeline-github-actions/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    resource_group_name  = "storage_account_resource_group_state"
    storage_account_name = "natanstorageaccountstate"
    container_name       = "remote-state"
    key                  = "azure-vnet/terraform.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      owner      = "natanael"
      managed-by = "terraform-1.1"
    }
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-natan-state"
    key    = "aws-vpc/terraform.state"
    region = "us-east-1"
  }
}