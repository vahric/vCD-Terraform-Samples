#vApp içersinde sanal sunucu oluşturalim
#https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/vapp_vm

    resource "vcd_vapp_vm" "DBServerServers"{

#Birden fazla sunucu olusturmak icin, count parametresini ekliyoruz
#https://jeffbrown.tech/terraform-count-foreach/
#https://www.terraform.io/docs/language/meta-arguments/count.html
      count = 2

      name="DBServer-${count.index}"
      computer_name="DB-1"
      description="TestDBSanalSunucu-${count.index}"

# vapp name pls :D 

      vapp_name="dbserversgroup"

#DorukCloud'da musterilerin hizli kurulum yapmalari için paylastirilmis kataloglardan biri ve o katalogdaki imajin adi verilmis

      catalog_name="Doruknet-Linux-Templates"
      template_name="vCD-Centos7-Minimal-Template"
      cpus=2
      memory=2048

#Zorunlu olmayan bir k/v fakat ozellikle sanal sunucularinizi kapatip acmaya gerek kalmadan ram/cpu eklemek icin kullanabilirsiniz

      cpu_hot_add_enabled=true
      memory_hot_add_enabled=true
      power_on=true

#Storage profile verilmesi zorunlu degil fakat birden fazla storage profile atanmis musteriler icin secimin nasil
#yapilabilecegini gostermek amaciyla eklenmistir.

      storage_profile="AllFlash7200-B-DSC-01"

#Sanal sunucuyu baglayacagimiz networku belirtin
#Asagida daha once terraform ile olusturulmus olan databasenetwork kaynaginda belirtilmis networke baglanacagimizi belirtiyoruz
#name burada birdegisken olarak geliyor ve DBNetwork1'i isaret ediyor...

    network{
      name=vcd_network_routed_v2.DBRoutedServerNetwork.name
      type="org"
      ip_allocation_mode="POOL"
    }

#Ozellestirme ise daha cok windows'lardaki sysprep gibi dersek bir cagirism yapabilir
#Burada kurmak istediğimiz Centos'un sifresinin otomatik atanmasini istiyoruz

    customization{
      enabled=true
      allow_local_admin_password=true
      auto_generate_password=true
    }

#Sunucu ile ilgili tag'lamanız gereken bilgiler var ise belirtebilirsiniz

    metadata={
      role="web"
      env="staging"
      version="v1"
      my_key="myvalue"
    }

   depends_on = [
     vcd_vapp_org_network.OrgWebNetwork, vcd_vapp_org_network.OrgDatabaseNetwork,
  ]
}
