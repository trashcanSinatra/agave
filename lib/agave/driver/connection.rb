module Agave
   class Connection

      attr_accessor :adapter

      def initialize(config)
         config.each do |key, val|
            puts "#{key} : #{val}"
         end
      end

   end
end
