cloudstack-barclamp--crowbar-1.2-POC
====================================

a basic barclamp for crowbar 1.2 to install and configure a minimal cloudstack 2.2.13-1 cluster

About crowbar 1.2
-------------------------------------

The Crowbar Framework (https://github.com/dellcloudedge/crowbar) was developed by the Dell CloudEdge Solutions Team (http://dell.com/openstack) as a OpenStack installer (http://OpenStack.org) but has evolved as a much broader function tool. 
A Barclamp is a module component that implements functionality for Crowbar.  Core barclamps operate the essential functions of the Crowbar deployment mechanics while other barclamps extend the system for specific applications.

* The functionality of this barclamp DOES NOT stand alone, the Crowbar 1.2 Framework is required * 

About this particular barclamp
-------------------------------------

this small barclamp is the result of a brief investigative work to figure out how crowbar could be coerced in deploying cluster based software out of its comfort zone of openstack, hadoop and DELL hardware.
It is by no means fully featured, maintained or even properly tested as i only did the bare minimum to know what i wanted to know.


What it does:
 - allows the installation and partial configuration of a cloudtsack management server, a DB server and usage server.

 
What it doesn't do:
 - install compute nodes (incidentaly the most beneficial part to automate for a compute service :) ): This is because crowbar supports only a single OS in a given cluster. Also XEN isn't in the list of crowbar supported OSes (Switching to KVM should remove that blocker though).
 - configure the cloudstack cluster itself (i.e. what you'd normally do via the web management console): This is because i could not find any management CLI tools or API I could use. The cloudstack docs mentioned something called 'cloudadm' but I couldn't actually find it anywhere.
 - provision he ISCSI storage: simply not done.
 - provision he NFS storage: simply not done.
 
 
Notes on crowbar in regards to this particular POC:
 - no OS choice: the only OS crowbar supports in a given cluster is the one it was packaged with. In our case this is ubuntu 10.10 which caused quite a bit of pain as cloudstack 2.2.13 only supports 10.04 and simply doesn't work out of the box on 10.10... forcing me to hack around a bit to shoe horn it.
 - no support for custom image/ISO provisioning: Which in our case means no easy way to install XEN,... or any other software appliance
 - feedback and failure handling via UI not quite there yet: the crowbar UI didn't always let me know when a deployment had gone astray. When it happened, it usually left the related proposals and nodes stuck in some intermediary state preventing me to take any corrective action via the web UI and forcing me to manually clean things up in chef or via a handful of CLI tools provided.
 
 
To install:
 - setup a crowbar admin node:
   - General instructions can be found here: https://github.com/dellcloudedge/crowbar/wiki/Install-crowbar
   - I used the 1.2 final build: http://crowbar.zehicle.com/crowbar111219.iso
   - Make sure to configure the networking before finalising the install (i.e. actually calling the 'install' script) by editing '/opt/dell/chef/data_bags/crowbar/bc-template-network.json'. See here for details on the configuration file: https://github.com/dellcloudedge/crowbar/wiki/Annotated-network-json-file

 - install the barclamp:
   - call '/opt/dell/bin/barclamp_install' against the extracted barclamp directory.
   - optionally bounce the 'crowbar' service (otherwise some UI elements will not load). You could also restart crowbar in dev mode via '/opt/dell/bin/dev_mode.sh' for extra logs

   
To deploy a proposal,
 - follow a normal crowbar workflow:
   - start at least 2 machines to PXE boot on the crowbar admin network
   - once they show up as 'discovered'/yellow, allocate them with a 'virtualization' bios setting
   - once they come back as ready/ green (could take a while as they will go through a full OS install), switch to the barclamp section and create a proposal for cloudstack
   - in the proposal editor switch to the raw views to see all the config options.
   - apply the proposal
   - wait until the UI becomes responsive again while crowbar does its thing.


Legals
-------------------------------------
The code and documentation is distributed under the Apache 2 license (http://www.apache.org/licenses/LICENSE-2.0.html). Contributions back to the source are encouraged.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
