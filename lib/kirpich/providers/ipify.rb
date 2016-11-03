module Kirpich::Providers
  class Ipify
    class << self

      def get_ip
      	
        response = Faraday.get 'https://api.ipify.org?format=json'
        result = JSON.parse response.body

        if result['ip']
        	result['ip']
        else
        	''
        end

      end

    end
  end
end
