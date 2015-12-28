module Agave

   def self.Table(name, keyword, id=nil, *args, &block)
      # Capture builder object.
      qryObject = Agave::Query.builder
      qryObject.table = name

      case keyword
         when :select
            if block
               then yield qryObject
            else
              qryObject.selects = "*"
           end
           qryObject.select
         when :insert
            puts qryObject.conn
         when :delete
            puts qryObject.conn
         when :find
            puts qryObject.conn
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
      attr_accessor :conn, :table, :selects


      def select()
         if selects
            puts "SELECT #{@selects} FROM #{@table}"
         end
      end

      def insert()
      end

      def delete()
      end

      def find()
      end

      def columns(*columns)
         if columns
            @selects = columns.join(", ").chomp
         end
      end

      class << self

         attr_accessor :builder

         def make(connection)
            @builder = Agave::Query.new
            @builder.conn = connection
         end

      end

   end


end
