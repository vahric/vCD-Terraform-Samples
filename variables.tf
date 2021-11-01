# Terraform degiskenler ve degiskenlerin farklı bir dosyada tutulmasi hakkinda linkler
#
#https://www.terraform.io/docs/language/values/variables.html
#https://www.terraform.io/docs/language/expressions/types.html
#
#
#

variable "dorukvcloudkullanici" {
  description = "DorukCloud Portal Kullanicisi"
  type = string
  default = "vahric"
}

variable "dorukvcloudsifre" {
  description = "DorukCloud Portal Sifresi"
  type = string
}

variable "dorukcloudorgadi" {
  description = "DorukCloud Organizasyon adi"
  type = string
  default = "Lina-Tenant1"
}

variable "dorukcloudvcdadi" {
  description = "DorukCloud VCD Adi"
  type = string
  default = "Lina-Payg-Test1-On-AMD"
}
