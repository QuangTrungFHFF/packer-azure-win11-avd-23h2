variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "subscription_id" {}
variable "password" {}

locals {
  timestamp = formatdate("YYYYMMDDhhmmss", timestamp())
}

packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2.3.3"
    }
  }
}


source "azure-arm" "win11-23h2" {
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id

  location                          = "germanywestcentral"
  temp_resource_group_name          = "rg-trung-packer-temp"
  managed_image_resource_group_name = "rg-ms-image-test"
  managed_image_name                = "win11-23h2-avd-${local.timestamp}"

  os_type         = "Windows"
  image_publisher = "MicrosoftWindowsDesktop"
  image_offer     = "windows-11"
  image_sku       = "win11-23h2-avd"
  image_version   = "22631.5335.250509"

  communicator   = "winrm"
  winrm_use_ssl  = true
  winrm_insecure = true
  winrm_timeout  = "5m"
  winrm_username = "packer"
  winrm_password = var.password

  vm_size = "Standard_D2s_v4"
}

build {
  name = "azure-win11-23h2-trung"
  sources = [
    "source.azure-arm.win11-23h2"
  ]

  provisioner "powershell" {
    
    inline = [
      "Set-ExecutionPolicy Bypass -Scope Process -Force;"
    ]
  }

 # Install Language Pack 
  provisioner "powershell" {
    elevated_user     = "packer"
    elevated_password = var.password
    script            = "scripts/setup.ps1"
  }

  provisioner "windows-restart" {
    restart_timeout = "7m"
  }

#Setup configuration
  provisioner "powershell" {
    elevated_user     = "packer"
    elevated_password = var.password
    script            = "scripts/postsetup.ps1"
  }


}