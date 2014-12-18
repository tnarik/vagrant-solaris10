# Copyright (c) 2014 Tnarik Innael - adaptation to Solaris and repackaging
# Copyright (c) 2013-2014 timsutton/kalmanh/lsimons - from plugins/guests/darwin/cap/mount_vmware_shared_folder.rb
module Vagrant
  module Solaris10
    module Cap
      class MountVmwareSharedFolder

        def self.mount_vmware_shared_folder(machine, name, guestpath, options)
          machine.communicate.tap do |comm|
            # clear prior symlink
            if comm.test("test -L \"#{guestpath}\"", sudo: true)
              comm.sudo("rm -f \"#{guestpath}\"")
            end
  
            # clear prior directory if exists
            if comm.test("test -d \"#{guestpath}\"", sudo: true)
              comm.sudo("rm -Rf \"#{guestpath}\"")
            end
  
            # finally make the symlink
            comm.sudo("ln -s \"/hgfs/#{name}\" \"#{guestpath}\"")
          end
        end
        
      end
    end
  end
end