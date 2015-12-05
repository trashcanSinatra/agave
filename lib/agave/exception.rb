module Agave
   module Error

      class Standard < StandardError
        def self.header
           header = "\nAGAVE EXCEPTION! \n"
           header << "---------------- \n"
        end
      end

      class InvalidDriverKey < Standard
         def message (key, config)
            error = Standard::header
            error << "\"#{key}\" is not in the driver config."
            error << "  It will not be set. \n\n"
            error << "Available options: \n"
            config.each {|k,v| error << "\t\t #{k} \n" }
            error << "\n"
         end

         def self.check_otpion?(key, config)
             return false if config.key?(key)
             raise Error::InvalidDriverKey unless config.key?(key)
             exit
         end
      end

   end
end
