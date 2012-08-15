name "cloudstack-dbserver"
description "Cloudstack DB Server Role - DB server for cloudstack cluster"
run_list(
         "recipe[cloudstack::setuprepos]",
         "recipe[cloudstack::setuprepos]",
         "recipe[cloudstack::dbserver]"
)
default_attributes()
override_attributes()