module Vagrant
  module Solaris10
    module Cap
      class RSync

        def self.rsync_post(machine, opts)
          machine.communicate.sudo(
            "find '#{opts[:guestpath]}' '(' ! -user #{opts[:owner]} -o ! -group #{opts[:group]} ')' " +
            " -exec chown #{opts[:owner]}:#{opts[:group]} {} +")
        end
        
      end
    end
  end
end