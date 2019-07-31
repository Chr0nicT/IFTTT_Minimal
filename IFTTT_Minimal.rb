require 'net/http'
require 'uri'
require 'date'
require 'json'

class IFTTT_Minimal
    @@key = 0
    @@event = 0

    #VARS
    @@var1 = "NEVER_NO_VAL"
    @@var2 = "NEVER_NO_VAL"
    @@var3 = "NEVER_NO_VAL"

    def initialize(key, event)
      @@key = key
      @@event = event
    end

    #SETTER
    def self.var1=(val)
        @@var1 = val
    end

    def self.var2=(val)
        @@var2 = val
    end

    def self.var3=(val)
        @@var3 = val
    end
  
    def self.fire
        uri = URI.parse("https://maker.ifttt.com/trigger/" + @@event.chomp + "/with/key/" + @@key.chomp)
        request = Net::HTTP::Post.new(uri)

        


        #There is a better way to do this for sure but ima take the easy way
        if @@var1.chomp != "NEVER_NO_VAL" && @@var2.chomp == "NEVER_NO_VAL" && @@var3.chomp == "NEVER_NO_VAL"
            request.content_type = "application/json"
            request.body = JSON.dump({
                "value1" => @@var1
            })
        end
        if @@var1.chomp != "NEVER_NO_VAL" && @@var2.chomp != "NEVER_NO_VAL" && @@var3.chomp == "NEVER_NO_VAL"
            request.content_type = "application/json"
            request.body = JSON.dump({
                "value1" => @@var1,
                "value2" => @@var2
            })
        end

        if @@var1.chomp != "NEVER_NO_VAL" && @@var2.chomp != "NEVER_NO_VAL" && @@var3.chomp != "NEVER_NO_VAL"
            request.content_type = "application/json"
            request.body = JSON.dump({
                "value1" => @@var1,
                "value2" => @@var2,
                "value3" => @@var3
            })
        end

        req_options = {
            use_ssl: uri.scheme == "https",
        }
          
        response = Net::HTTP.start(uri.hostname, uri.port, req_options)
        real_response = response.request(request)
        puts "IFTTT Said: " + real_response.body


    end
  end
