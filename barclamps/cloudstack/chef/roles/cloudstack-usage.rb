name "cloudstack-usage"
description "Cloudstack Usage Monitor Role - Usage Monitor for cloudstack cluster"
run_list(
         "recipe[cloudstack::setuprepos]",
         "recipe[cloudstack::setuprepos]",
         "recipe[cloudstack::usage]"
)
default_attributes()
override_attributes()