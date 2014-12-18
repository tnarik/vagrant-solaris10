# Copyright (c) 2014 Tnarik Innael - adaptation to Solaris and repackaging
# Copyright (c) 2013-2014 timsutton/kalmanh/lsimons - from plugins/guests/darwin/cap/mount_vmware_shared_folder.rb
module Vagrant
  module Solaris10
    module Cap
      class MountParallelsSharedFolder

        def self.mount_parallels_shared_folder(machine, name, guestpath, options)
          machine.ui.warn("Parallels doesn't support shared folders for Solaris")
        end
        
      end
    end
  end
end