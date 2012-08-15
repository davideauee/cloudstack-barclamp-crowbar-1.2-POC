# Copyright 2012
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

override[:cloudstack][:user]="cloudstack"

# declare what needs to be monitored
node[:cloudstack][:monitor]={}
node[:cloudstack][:monitor][:svcs] = []
node[:cloudstack][:monitor][:ports]={}

default[:cloudstack][:mysql][:root_pwd] = "bob"
default[:cloudstack][:mysql][:cloud_pwd] = "bob"
