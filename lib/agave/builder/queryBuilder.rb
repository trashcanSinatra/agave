module Agave

   def self.Table(name, keyword, id=nil, &block)
      case keyword
         when :select
            puts Agave::Query.builder.conn
            puts "SELECT * FROM #{keyword}"
         when :insert
            puts Agave::Query.builder.conn
            puts "SELECT * FROM #{keyword}"
         when :delete
            puts Agave::Query.builder.conn
            puts "SELECT * FROM #{keyword}"
         when :find
            puts Agave::Query.builder.conn
            puts "SELECT * FROM #{name} where id = #{id}"
      end
   end

   class Query
      include Agave
      attr_accessor :conn

      def initialize()
      end

      class << self

         attr_accessor :builder

         def make(connection)
            @builder = Agave::Query.new
            @builder.conn = connection.clone
         end

      end

   end


end
