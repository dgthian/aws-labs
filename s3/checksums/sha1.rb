require 'digest/sha1'

filename = "myfile.txt"
sha1 = Digest::SHA1.file(filename).hexdigest

puts "SHA1 checksum: #{sha1}"
