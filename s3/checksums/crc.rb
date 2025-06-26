require 'zlib'
## return Checksum for myflie.txt

crc32 = Zlib::crc32(File.read('myfile.txt'))
puts "CRC32 Checksum: #{crc32}"