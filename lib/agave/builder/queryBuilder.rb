module Agave

   def self.Table(name, keyword, id=nil, *args, &block)
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
            stmt = "SELECT * FROM #{name} where "
            if args and args.size == 1
               stmt << "#{args[0]} = #{id}"
            else
               stmt << "id = #{id}"
            end
            puts stmt
      end
   end

   class Query
      include Agave
      attr_accessor :conn


      def select()
      end

      def insert()
      end

      def delete()
      end

      def find()
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
