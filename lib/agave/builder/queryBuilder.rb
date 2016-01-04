module Agave

   @liveConnection

   def self.connection(conn)
      @liveConnection ||= conn
   end

   def self.Table(name, keyword, id=false, &block)
      # Capture builder object.
      qryObject = Agave::Query.make @liveConnection
      qryObject.table = name

      case keyword
         when :select
            if block
               then yield qryObject
            else
              qryObject.where_params(:id, id) if id
           end
           puts qryObject
           qryObject.select
         when :insert
            puts qryObject.conn
         when :delete
            puts qryObject.conn
      end
   end

   class Query
      include Agave
      attr_accessor :conn, :table, :selects, :wheres


      def get_where(key)
         @wheres[key]
      end

      def where_params(key, val)
         @wheres[key] = val
      end

      def select()
         qry = "SELECT #{@selects} FROM #{@table}"
         if @wheres[:id]
            qry << " WHERE id = #{get_where(:id)}"
         end
         puts qry
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
            Agave::connection(connection)
            @builder = Agave::Query.new
            @builder.conn = connection
            @builder.selects = "*"
            @builder.wheres = {}
            return @builder
         end

      end

   end


end
