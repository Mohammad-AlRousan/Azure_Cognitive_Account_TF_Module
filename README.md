<!-- BEGIN_TF_DOCS -->
# Terraform Cognitive Services Module

This Terraform module facilitates the management of Azure Cognitive Services. It offers a comprehensive set of variables and resources to configure and deploy Cognitive Services in Azure.

## Overview

This README provides documentation for the Azure Cognitive Services Account module in Terraform. The module is designed to create and manage Azure Cognitive Services Accounts using the Azure Resource Manager (azurerm) provider.

## Usage

To use this module, include it in your Terraform configuration and provide the necessary input variables.

## Inputs

- **resource_group_name**: The name of the resource group in which to create the Cognitive Services Account.
- **location**: The Azure region where the Cognitive Services Account should be created.
- **account_name**: The name of the Cognitive Services Account.
- **kind**: The kind of Cognitive Services Account to create (e.g., CognitiveServices, Face, TextAnalytics).
- **sku_name**: The SKU of the Cognitive Services Account (e.g., S1, S2).
- **tags**: A map of tags to assign to the resource.

## Outputs

- **id**: The ID of the created Cognitive Services Account.
- **endpoint**: The endpoint URL of the Cognitive Services Account.
- **primary_access_key**: The primary access key for the Cognitive Services Account.
- **secondary_access_key**: The secondary access key for the Cognitive Services Account.

This module simplifies the process of creating and managing Azure Cognitive Services Accounts, ensuring that all necessary resources are properly configured and provisioned.