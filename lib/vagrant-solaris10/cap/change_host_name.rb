# Copyright (c) 2014 Tnarik Innael - fix to properly work with Solaris 10 and repackaging
# Copyright (c) 2013 Mitchell Hashimoto - from plugins/guest/solaris/cap/change_host_name.rb
module Vagrant
  module Solaris10
    module Cap
      class ChangeHostName

        def self.change_host_name(machine, name)

          # Only do this if the hostname is not already set
          machine.communicate.tap do |comm|
            if !comm.test("hostname | grep '#{name}", sudo: true)
              ifconfig = nil
              # Get ifconfig output
              comm.execute("ifconfig -a") do |type, data|
                if type == :stdout
                  ifconfig ||= ""
                  ifconfig += data
                end
              end

              broadcasting_interface = ifconfig.scan(/^(\w+).*BROADCAST/)[0][0]
              broadcasting_ip = ifconfig.scan(/inet\s(\S+).*broadcast/)[0][0]

              comm.sudo("sh -c \"echo '#{name}' > /etc/nodename\"")
              comm.sudo("sh -c \"echo '#{name}' > /etc/hostname.#{broadcasting_interface}\"")
              comm.sudo("sh -c \"gsed -i -e 's/\\(#{broadcasting_ip}\\s*\\).*/\\1#{name}/g' /etc/hosts\"")

              comm.sudo("uname -S #{name}")
            end
          end

        end
        
      end
    end
  end
end