#SNAT Web Sunucularin Internet'e Erişimi İçin
#Referans https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/nsxt_nat_rule

# Not, kullanılan kod versionu 3.4.0 olup VMware Cloud Director 10.3 ile test edilmiştir

resource "vcd_nsxt_nat_rule" "dbsnat" {

  edge_gateway_id = data.vcd_nsxt_edgegateway.varolan.id

  name        = "DB Server SNAT Kurali"
  # DNAT, SNAT, NO_DNAT, NO_SNAT, REFLEXIVE tipleri mevcut, burada SNAT kullanıyoruz.
  rule_type   = "SNAT"
  description = "DB Sunucuların Internet'e Tek Bir IP Adresi İle Çıksınlar"

  # edge gateway primary ip adresini kullanıyoruz
  # external_address         = tolist(data.vcd_nsxt_edgegateway.varolan.subnet)[0].primary_ip
  external_address         = "82.151.159.3"
  internal_address         = "10.8.8.0/24"

# SNAT yaparken belli bir ip adresine dogru yapilabileceği gibi, bu değiskeni tanımlamazsanız
# Herhangi bir adrese doğru yine SNAT uygulanacaktir.
# snat_destination_address = "8.8.8.8"

#Loglama kapali
  logging                  = false

}



#DNAT Disaridan iceriye http/https erisimi icin




#SNAT ve DNAT kurallarının çalışabilmesi için uygulanacak firewall kurali
#Referans https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/nsxt_firewall

# DB Server'la Internet'e doğru any izin verelim

resource "vcd_nsxt_firewall" "dbSNATmatch" {

  edge_gateway_id = data.vcd_nsxt_edgegateway.varolan.id

  # Rule #1 - Allows in IPv4 traffic from security group `vcd_nsxt_security_group.group1.id`
  rule {
    action      = "ALLOW"
    name        = "DB Server Internet Access"
    direction   = "OUT"
    ip_protocol = "IPV4"
    source_ids  = [vcd_nsxt_security_group.DBSunuculari.id]
  }

}

