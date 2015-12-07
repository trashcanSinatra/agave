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
      end

      class RequiredDriverKey < Standard
         def message (cls, required)
            error = Standard::header
            error << "\"#{cls}\" requires the following\n"
            error << "options to be set for connection:\n"
            required.each {|k| error << "\t\t #{k} \n" }
            error << "\n"
         end
      end


   end
end
