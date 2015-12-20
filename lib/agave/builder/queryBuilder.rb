module Agave
   class Query

      attr_accessor :conn

      def initialize()
      end

      class << self

         attr_accessor :builder

         def make(connection)
            @builder = Agave::Query.new
            @builder.conn = connection.clone
         end

         def select
            puts self.builder.conn
            puts self.builder
         end
      end

   end
end
