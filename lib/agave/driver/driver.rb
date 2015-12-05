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
        begin
           @config.each do |k,v|
             unless Error::InvalidDriverKey.check_otpion? key, @config
                @config[key] = val
             end
           end
        rescue Agave::Error::Standard => exception
           puts exception.message key, @config
        end
      end # METHOD: option

     def self.config
       @config
     end


  end # MODULE: Adapter


   class SQLite
     include Adapter

      class << self

         def connect(db)
            Agave::Adapter.option(:drver, 'sqlite')
            Agave::Adapter.option(:database, db)
            conn = Agave::Connection.new(Agave::Adapter.config)
         end

      end # CLASS : self

   end # CLASS : SQLite



   class MySQL
   end

   class PG

   end

end
