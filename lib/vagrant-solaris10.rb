require "vagrant-solaris10/version"
require "vagrant"

module Vagrant
  module Solaris10

    class Plugin < Vagrant.plugin("2")
      name "Solaris10 guest"
      description "Solaris10 guest support."

      guest_capability("solaris", "mount_vmware_shared_folder") do
        require_relative "cap/mount_vmware_shared_folder"
        Cap::MountVmwareSharedFolder 
      end

      guest_capability("solaris", "mount_parallels_shared_folder") do
        require_relative "cap/mount_parallels_shared_folder"
        Cap::MountParallelsSharedFolder 
      end

      guest_capability("solaris", "insert_public_key") do
        require_relative "cap/insert_public_key"
        Cap::InsertPublicKey
      end

      guest_capability("solaris", "remove_public_key") do
        require_relative "cap/remove_public_key"
        Cap::RemovePublicKey
      end

      guest_capability("solaris", "rsync_post") do
        require_relative "cap/rsync"
        Cap::RSync
      end
    end
  end
end