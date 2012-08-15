name "cloudstack-mgtserver"
description "Cloudstack Management Server Role - management server for cloudstack cluster"
run_list(
         "recipe[cloudstack::setuprepos]",
         "recipe[cloudstack::setuprepos]",
         "recipe[cloudstack::mgtserver]"
)
default_attributes()
override_attributes()