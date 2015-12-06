module Agave
   module Error

      class Standard < StandardError
        def self.header
           header = "\nAGAVE EXCEPTION! \n"
           header << "---------------- \n"
        end
      end

      class DriverKey < Standard
         def message (key, config)
            error = Standard::header
            error << "\"#{key}\" is not in the driver config."
            error << "  It will not be set. \n\n"
            error << "Available options: \n"
            config.each {|k,v| error << "\t\t #{k} \n" }
            error << "\n"
         end
      end

   end
end
