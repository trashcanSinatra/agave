module Agave
   module Adapter
      @config =
       {
        :driver => nil,
        :host => nil,
        :database => nil,
        :username => nil,
        :password => nil,
        :charset => 'utf8'
      }

      def self.option(key, val)
        @config[key] = val
      end

     def self.config
       @config
     end


  end # MODULE: Adapter


   class SQLite

     include Adapter

      class << self

         def connect(db)
            Agave::Adapter.option(:driver, 'sqlite')
            Agave::Adapter.option(:database, db)
            conn = Agave::Connection.new(Agave::Adapter::config)
         end

      end
   end

   class MySQL
   end

   class PG

   end

end
