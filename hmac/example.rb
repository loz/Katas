require 'securerandom'
require 'openssl'

key = SecureRandom.hex(8)
secret = SecureRandom.hex(24)

puts "KEY", key
puts "SECRET", secret

request = '/dothing/foo/?stuff=foo&bar=baz'

def digest(request, key, secret)
  OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'), secret, request)
end

def validate(request, key, secret, signed)
  digest(request, key, secret) == signed
end

signed = digest(request, key, secret)

puts "GET: #{request}"
puts 'Headers'
puts "ClientKey: #{key}"
puts "Digest: #{signed}"
puts ''

puts 'Validates Unmodified:', validate(request, key, secret, signed)

modified = request + '&naughty=true'
puts "Modify request: #{modified}"
puts 'Validates Modified:', validate(modified, key, secret, signed)
