module Agave

   def self.Table(name, keyword, id=false, &block)
      # Capture builder object.
      qryObject = Agave::Query.builder
      qryObject.table = name

      case keyword
         when :select
            if block
               then yield qryObject
            else
              qryObject.selects = "*"
              qryObject.where_params(:id, id) if id
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
      attr_accessor :conn, :table, :selects, :wheres


      def get_where(key)
         @wheres[key]
      end

      def where_params(key, val)
         @wheres[key] = val
      end

      def select()
         if @selects
            qry = "SELECT #{@selects} FROM #{@table}"
         end
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
            @builder = Agave::Query.new
            @builder.conn = connection
            @builder.wheres = {}
         end

      end

   end


end
