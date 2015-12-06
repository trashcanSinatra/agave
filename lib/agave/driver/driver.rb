module Agave
   module Adapter

      @config =
       {
        :driver => nil,
        :host => nil,
        :database => nil,
        :username => nil,
        :password => nil,
        :prefix => nil,
        :charset => 'utf8'
      }


      def self.set(key, val)
         begin
            @config[key] = val << "_" if key == :prefix
            @config.each do |k,v|
               unless Adapter::Exception.valid_key? key, @config
                  @config[key] = val
               end
            end
         rescue Agave::Error::Standard => e
            puts e.message key, @config
         end
      end # METHOD: option


      private

      def self.set_driver(cls)
         case cls
         when 'Agave::SQLite'
            Adapter.set :driver, 'sqlite'
         when 'Agave::MySQL'
            Adapter.set :driver, 'mysql'
         when 'Agave::PostgreSQL'
            Adapter.set :driver, 'pgsql'
         else
            Adapter.set :driver, 'sqlite'
         end
      end


      def self.clear
         @config.map do |k,v|
            @config[k] = k == :charset ? 'utf8' : nil
         end
      end


      def self.config
       @config
      end


      class Exception

         def self.valid_key?(key, config)
             return false if config.key? key
             raise Error::DriverKey unless config.key? key
             exit
         end

      end #CLASS: Adapter::Exception
  end #MODULE: Adapter


  class AdapterConnection
     include Adapter

     class << self

        def connect(&block)
           Adapter.set_driver(self.to_s)
           block.call(Agave::Adapter)
           conn = Agave::Connection.new Adapter.config
           Adapter.clear
           conn
        end

     end #CLASS : self

  end #CLASS : AdapterConnection


   class SQLite < AdapterConnection; end #CLASS : SQLite

   class MySQL < AdapterConnection; end #CLASS: MySQL

   class PostgreSQL < AdapterConnection; end #CLASS: PostreSQL

end # MODULE:Agave
