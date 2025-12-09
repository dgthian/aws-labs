require "base64"
text = 'Send reinforcements'

enc   = Base64.encode64('Send reinforcements')
                    # -> "U2VuZCByZWluZm9yY2VtZW50cw==\n"
puts "encoded"
puts enc
plain = Base64.decode64(enc)
                    # -> "Send reinforcements"
puts "decoded"
puts plain