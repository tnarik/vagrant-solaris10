# Copyright (c) 2014 Tnarik Innael - adaptation to Solaris and repackaging
# Copyright (c) 2013-2014 Mitchell Hashimoto - from plugins/guests/darwin/cap/mount_vnfs_folder.rb
require "vagrant/util/retryable"
require "vagrant/errors"

module Vagrant
  module Errors
    class Vagrant::Errors::SolarisNFSMountFailed < VagrantError
      error_key(:solaris_nfs_mount_failed)
    end
  end

  module Solaris10
    module Cap
      class MountNFSFolder
        extend Vagrant::Util::Retryable

        def self.mount_nfs_folder(machine, ip, folders)
          folders.each do |name, opts|
            # Expand the guest path so we can handle things like "~/vagrant"
            expanded_guest_path = machine.guest.capability(
              :shell_expand_guest_path, opts[:guestpath])
  
            # clear prior symlink
            if machine.communicate.test("test -L \"#{expanded_guest_path}\"", sudo: true)
              machine.communicate.sudo("rm -f \"#{expanded_guest_path}\"")
            end
  
            # Create the folder if doesn't exist
            if !machine.communicate.test("test -d \"#{expanded_guest_path}\"", sudo: true)
              machine.communicate.sudo("mkdir -p #{expanded_guest_path}")
            end

            # Figure out any options
            mount_opts = ["vers=#{opts[:nfs_version]}"]
            if opts[:mount_options]
              mount_opts = opts[:mount_options].dup
            end
  
            mount_command = "mount -F nfs " +
              "-o '#{mount_opts.join(",")}' " +
              "'#{ip}:#{opts[:hostpath]}' '#{expanded_guest_path}'"
            retryable(on: Vagrant::Errors::SolarisNFSMountFailed, tries: 10, sleep: 5) do
              machine.communicate.sudo(
                mount_command,
                error_class: Vagrant::Errors::SolarisNFSMountFailed)
            end
          end
        end
        
      end
    end
  end
end