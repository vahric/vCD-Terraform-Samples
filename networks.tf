#Routed Network (Sanal network) olusturma

#data source, var olan bir objeyi okuma, onun hakkındaki bilgileri edinmek için kullanilir, ansible'daki facts gibi
#asagida organizasyonunuzu atanmis Lina-VDC-X-EdgeGateway adındaki edge gateway bilgilerini terraform vmware cloud director dan okuyacak

# https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/edgegateway

# Not, kullanılan kod versionu 3.4.0 olup VMware Cloud Director 10.3 ile test edilmiştir

data "vcd_nsxt_edgegateway" "varolan" {
  name = "Lina-VDC-X-EdgeGateway"
}

#https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/network_routed_v2

resource "vcd_network_routed_v2" "DBRoutedServerNetwork" {
  name        = "DBServerNetwork"

#Buradaki edge_gateway_id , DB Network 1 hangi edge gateway üzerinde acilacagini belirtiyor, biraz önce data source ile 
#ilgili edge gw hakkinda bilgi almistik, burada acilacak ilgili network

  edge_gateway_id = data.vcd_nsxt_edgegateway.varolan.id

#Gateway ip, prefix ve dns bilgileri ataniyor

  gateway       = "10.8.8.1"
  prefix_length = 24
  dns1		= "8.8.8.8"
  dns2		= "8.8.4.4"

#Bir ip araligi verecektik sanal sunuculara atamak icin, asagida 100-200 arasini vermiş bulunmaktayiz

  static_ip_pool {
    start_address = "10.8.8.100"
    end_address   = "10.8.8.200"
  }

}

resource "vcd_network_routed_v2" "WebRoutedServerNetwork" {
  name        = "WebServerNetwork"

#Buradaki edge_gateway_id , DB Network 1 hangi edge gateway üzerinde acilacagini belirtiyor, biraz önce data source ile
#ilgili edge gw hakkinda bilgi almistik, burada acilacak ilgili network

  edge_gateway_id = data.vcd_nsxt_edgegateway.varolan.id

#Gateway ip, prefix ve dns bilgileri ataniyor

  gateway       = "10.9.9.1"
  prefix_length = 24
  dns1          = "8.8.8.8"
  dns2          = "8.8.4.4"

#Bir ip araligi verecektik sanal sunuculara atamak icin, asagida 100-200 arasini vermiş bulunmaktayiz

  static_ip_pool {
    start_address = "10.9.9.100"
    end_address   = "10.9.9.200"
  }

}
