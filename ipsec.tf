# https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/nsxt_ipsec_vpn_tunnel

# Not, kullanılan kod versionu 3.4.0 olup VMware Cloud Director 10.3 ile test edilmiştir

resource "vcd_nsxt_ipsec_vpn_tunnel" "ipsec-1" {
  
  edge_gateway_id = data.vcd_nsxt_edgegateway.varolan.id

  name = "ipsec Lina-VDC-X-EdgeGateway to Fortinet"
  description = "Önemli veri aktarimi"

  pre_shared_key = "preSHARED99!"

  local_ip_address = "82.151.159.2"
  local_networks   = ["10.9.9.0/24"]
  # Birden fazal network için array/dizi tanımlanabilir
  #local_networks   = ["10.10.10.0/24", "30.30.30.0/28", "40.40.40.1/32"]

  # Uzak Güvenlik cihazi public ip adresi
  remote_ip_address = "212.2.195.253"
  remote_networks = ["10.111.96.0/24"]
  # Birden fazal network için array/dizi tanımlanabilir
  #remote_networks   = ["192.168.1.0/24", "192.168.10.0/24", "192.168.20.0/28"]

# Varayili phase1 ve phase2 adımları uygulanacaktır, degisiklik yapmaniz gereken yerler için özelleştirme yapabilirsiniz.
#  security_profile_customization {
#    ike_version               = "IKE_V2"
#    ike_encryption_algorithms = ["AES_128"]
#    ike_digest_algorithms     = ["SHA2_256"]
#    ike_dh_groups             = ["GROUP14"]
#    ike_sa_lifetime           = 86400

 #   tunnel_pfs_enabled           = true
 #   tunnel_df_policy             = "COPY"
 #   tunnel_encryption_algorithms = ["AES_256"]
 #   tunnel_digest_algorithms     = ["SHA2_256"]
 #   tunnel_dh_groups             = ["GROUP14"]
 #   tunnel_sa_lifetime           = 3600

  #  dpd_probe_internal = "30"
#  }

}
