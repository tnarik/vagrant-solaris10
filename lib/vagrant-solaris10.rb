require "vagrant-solaris10/version"
require "vagrant"

module Vagrant
  module Solaris10
    class A
      def self.mount_parallels_shared_folder(machine, name, guestpath, options)
        p  "mount parallels"
      end

      def self.mount_vmware_shared_folder(machine, name, guestpath, options)
        p  "mount vmware"
      end

      # Copyright (c) 2014 Mitchell Hashimoto
      def self.insert_public_key(machine, contents)
        contents = contents.chomp
        contents = Vagrant::Util::ShellQuote.escape(contents, "'")

        machine.communicate.tap do |comm|
          comm.execute("mkdir -p ~/.ssh")
          comm.execute("chmod 0700 ~/.ssh")
          comm.execute("printf '#{contents}\\n' >> ~/.ssh/authorized_keys")
          comm.execute("chmod 0600 ~/.ssh/authorized_keys")
        end
      end

      # Copyright (c) 2014 Mitchell Hashimoto
      def self.remove_public_key(machine, contents)
        contents = contents.chomp
        contents = Vagrant::Util::ShellQuote.escape(contents, "'")

        machine.communicate.tap do |comm|
          if comm.test("test -f ~/.ssh/authorized_keys")
            comm.execute(
              "gsed -i '/^.*#{contents}.*$/d' ~/.ssh/authorized_keys")
          end
        end
      end
    end

    class Plugin < Vagrant.plugin("2")
      name "Solaris10 guest"
      description "Solaris10 guest support."

      guest_capability("solaris", "mount_vmware_shared_folder") do
        A 
      end

      guest_capability("solaris", "mount_parallels_shared_folder") do
        A 
      end

      guest_capability("solaris", "insert_public_key") do
        A 
      end

      guest_capability("solaris", "remove_public_key") do
        A 
      end
    end
  end
end