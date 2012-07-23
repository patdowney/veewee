require 'veewee/provider/core/provider'

module Veewee
  module Provider
    module Vmfusion
      class Provider < Veewee::Provider::Core::Provider

        #include ::Veewee::Provider::Vmfusion::ProviderCommand

        def check_requirements
          require 'fission'
          vmrun_path = ::Fission.config['vmrun_bin']
          
          unless File.exists?(vmrun_path)
            raise Veewee::Error,"The file '#{vmrun_path}' does not exists. Probably you don't have Vmware fusion installed"
          end
        end

      end #End Class
    end # End Module
  end # End Module
end # End Module
