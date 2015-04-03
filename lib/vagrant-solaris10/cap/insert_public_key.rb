# Copyright (c) 2014-2015 Tnarik Innael - repackaged
# Copyright (c) 2014 Mitchell Hashimoto - from plugins/guest/linux/cap/insert_public_key.rb
require "vagrant/util/shell_quote"

module Vagrant
  module Solaris10
    module Cap
      class InsertPublicKey

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
        
      end
    end
  end
end