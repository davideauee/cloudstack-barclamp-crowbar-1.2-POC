
name "cloudstack-agent"
description "Cloudstack agent Role - compute agent for cloudstack cluster"
run_list(
         "recipe[cloudstack::api]",
         "recipe[cloudstack::setuprepos]",
         "recipe[cloudstack::agent]"
)
default_attributes()
override_attributes()