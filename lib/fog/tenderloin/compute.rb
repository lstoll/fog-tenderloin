require 'fog/tenderloin'
require 'fog/compute'
require 'base64'
require 'json'

module Fog
  module Compute
    class Tenderloin < Fog::Service

      model_path 'fog/tenderloin/models/compute'
      # model       :server
      # collection  :servers

      request_path 'fog/tenderloin/requests/compute'
      # request :list_vms
      # request :lookup_vm
      # request :delete_vm

      class Mock

        def initialize(options)
        end

        def request(options)
          raise "Not implemented"
        end
      end

      class Real

        def initialize(options)
          @vm_glob     = options[:loinfile_glob] || "**/*.loin"
          @loin_cmd    = options[:loin_bin] || "loin"
        end

        def request(params, json_resp=false)
          params = params.join(" ") if params.kind_of? Array
          ret = `#{@loin_cmd} #{params}`

          if json_resp
            Fog::JSON.decode(ret)
          else
            ret
          end
        end

      end
    end
  end
end