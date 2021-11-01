#https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/vapp

resource "vcd_vapp" "webvappserversgroup" {
  name     = "webserversgroup"
  power_on = "true"
 
  depends_on = [
    vcd_network_routed_v2.WebRoutedServerNetwork,
  ]

}

resource "vcd_vapp" "dbvappserversgroup" {
  name     = "dbserversgroup"
  power_on = "true"

  depends_on = [
    vcd_network_routed_v2.DBRoutedServerNetwork,
  ]
}

#https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/vapp_org_network

resource "vcd_vapp_org_network" "OrgDatabaseNetwork" {

  vapp_name = "dbserversgroup"

  org_network_name = "DBServerNetwork"

  depends_on = [
    vcd_vapp.dbvappserversgroup,
  ]

}

resource "vcd_vapp_org_network" "OrgWebNetwork" {

  vapp_name = "webserversgroup"

  org_network_name = "WebServerNetwork"

  depends_on = [
    vcd_vapp.webvappserversgroup,
  ]


}
