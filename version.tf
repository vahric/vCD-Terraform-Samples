# Configure the VMware Cloud Director Provider for DorukCloud
terraform {
  required_providers {
    vcd = {
      source = "vmware/vcd"
    }
  }
  required_version = ">= 0.13"
}

# Doğrulama için gerekli erişim noktasi, kullanici adi ve sifre, vdc, organizasyon bilgisi
# Tüm bilgiler variables.tf dosyasinda verilmistir

provider "vcd" {
  user                 = var.dorukvcloudkullanici
  password             = var.dorukvcloudsifre
  auth_type            = "integrated"
  org                  = var.dorukcloudorgadi
  vdc		       = var.dorukcloudvcdadi
  url                  = "https://vcdistbal01.dorukcloud.com/api"
}
