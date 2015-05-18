# Copyright (c) 2014-2015 Tnarik Innael - adaptation to Solaris and repackaging
# Copyright (c) 2013-2014 timsutton/kalmanh/lsimons - from plugins/guests/darwin/cap/mount_vmware_shared_folder.rb
module Vagrant
  module Solaris10
    module Cap
      class MountVmwareSharedFolder

        def self.mount_vmware_shared_folder(machine, name, guestpath, options)
          owner = options[:owner]
          group = options[:group]
          machine.communicate.tap do |comm|
            if owner.is_a? Integer
              mount_uid = owner
            else
              mount_uid = "$(/usr/xpg4/bin/id -u #{owner})"
            end

            if group.is_a? Integer
              mount_gid = group
            else
              mount_gid = "$(/bin/getent group #{group}  | cut -d: -f3)"
            end

            # clear prior symlink
            if comm.test("test -L \"#{guestpath}\"", sudo: true)
              comm.sudo("rm -f \"#{guestpath}\"")
            end
  
            # clear prior directory if exists
            if comm.test("test -d \"#{guestpath}\"", sudo: true)
              comm.sudo("rm -Rf \"#{guestpath}\"")
            end
  
            # create guest parent folder if doesn't exist
            parent_guest_path = File.dirname(guestpath)
            if !comm.test("test -d \"#{parent_guest_path}\"", sudo: true)
              comm.sudo("mkdir -p \"#{parent_guest_path}\"")
            end

            # finally make the symlink
            comm.sudo("ln -s \"/hgfs/#{name}\" \"#{guestpath}\"")

            # Set permissions correctly on the link
            comm.sudo("chown -h #{mount_uid}:#{mount_gid} \"#{guestpath}\"")
          end
        end
        
      end
    end
  end
end