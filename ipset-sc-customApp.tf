# https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/nsxt_ip_set

# Not, kullanılan kod versionu 3.4.0 olup VMware Cloud Director 10.3 ile test edilmiştir

resource "vcd_nsxt_ip_set" "WebAdmins" {

  edge_gateway_id = data.vcd_nsxt_edgegateway.varolan.id

  name        = "WebAdmins"
  description = "Web Server Yöneticilerin Statik IP leri"

  ip_addresses = [
    "12.12.12.1",
    "192.168.1.0/24",
    "13.11.11.1-13.11.11.5",
  ]

}

# https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/nsxt_security_group

resource "vcd_nsxt_security_group" "WebSunuculari" {


  # Referring to a data source for existing NSX-T Edge Gateway
  edge_gateway_id = data.vcd_nsxt_edgegateway.varolan.id

  name        = "WebSunuculari"
  description = "WebSunucularini tanımlayan Security Group"

  member_org_network_ids = [vcd_network_routed_v2.WebRoutedServerNetwork.id]
}

resource "vcd_nsxt_security_group" "DBSunuculari" {


  # Referring to a data source for existing NSX-T Edge Gateway
  edge_gateway_id = data.vcd_nsxt_edgegateway.varolan.id

  name        = "DBSunuculari"
  description = "DBSunucularini tanımlayan Security Group"

  member_org_network_ids = [vcd_network_routed_v2.DBRoutedServerNetwork.id]
}

# https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/nsxt_app_port_profile

#│ Error: error creating NSX-T Application Port Profile 'Plesk Management Port': error creating NSX-T Application Port Profile: error in HTTP POST request: BAD_REQUEST - [ e5d809f2-8a21-4c7e-b8ea-b2d5760d9d4a ] Application Port Profile Plesk Management Port already exists in Organization 4ff84927-010e-4657-9ef5-8d2e8653a93d.

#resource "vcd_nsxt_app_port_profile" "custom-app" {

 # name        = "Plesk Management Port"
 # description = "Plesk Management Port 8443"

 #  scope = "TENANT"

 # app_port {
 #   protocol = "TCP"
 #   port = ["8443"]
    #port     = ["2000", "2010-2020", "12345", "65000"]
 # }

#}
