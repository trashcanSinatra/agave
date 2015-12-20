module Agave
   class Connection


      def initialize(config)
         @@adapter = config
         Agave::Query.make @@adapter
      end

   end
end
