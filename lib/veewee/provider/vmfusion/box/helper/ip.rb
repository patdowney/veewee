require 'ipaddr'

module Veewee
  module Provider
    module Vmfusion
      module BoxCommand

        # Get the IP address of the box
        def ip_address
          return raw.network_info.data['ethernet0']['ip_address'] #.ip_address
        end

        # Note: I think this should be in fission rather than veewee
        def nat_config_path
          nat_file = "/Library/Application Support/VMware Fusion/vmnet8/nat.conf"
          if(! File.exists?(nat_file))
            nat_file = "/Library/Preferences/VMware Fusion/vmnet8/nat.conf"
          end
          return nat_file
        end

        # http://www.thirdbit.net/articles/2008/03/04/dhcp-on-vmware-fusion/
        def host_ip_as_seen_by_guest
          gateway=File.open(nat_config_path).readlines.grep(/ip = /).first.split(" ")[2]

          # vmware always uses class C netmasks for 
          # http://www.vmware.com/support/ws55/doc/ws_net_advanced_ipaddress.html
          gw_net = IPAddr.new "#{gateway}/24"
          # we want the first ip address, index 0 is the network
          host_ip = gw_net.to_range.entries[1].to_s
          return host_ip
        end

      end
    end
  end
end
