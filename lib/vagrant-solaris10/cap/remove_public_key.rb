# Copyright (c) 2014 Tnarik Innael - adaptation to Solaris and repackaging
# Copyright (c) 2014 Mitchell Hashimoto - from plugins/guest/linux/cap/remove_public_key.rb
module Vagrant
  module Solaris10
    module Cap
      class RemovePublicKey

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
    end
  end
end