module Agave

   @liveConnection

   def self.connection(conn)
      @liveConnection ||= conn
   end

   def self.Table(name, keyword, id=false, &block)
      # Capture builder object.
      qryObject = Agave::Query.make @liveConnection, name
      case keyword
         when :select
            if block
               then yield qryObject
            else
              qryObject.where_params(:id, id)
           end
           qryObject.select
         when :insert
            puts qryObject.conn
         when :delete
            puts qryObject.conn
      end
   end

   class Query
      include Agave
      attr_accessor :query, :table, :selects, :wheres


      def get_where(key)
         @wheres[key]
      end

      def where_params(key, val)
         @wheres[key] = val
      end

      def select()
         @query = "SELECT #{@selects} FROM #{@table}"
         if @wheres[:id]
            @query << " WHERE id = #{get_where(:id)}"
         end
         puts @query
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

         attr_reader :builder

         def set(connection)
            Agave::connection(connection)
         end

         def make(connection, tbl)
            @builder = Agave::Query.new
            @builder.table = tbl
            @builder.selects = "*"
            @builder.wheres = {}
            return @builder
         end

      end

   end


end
