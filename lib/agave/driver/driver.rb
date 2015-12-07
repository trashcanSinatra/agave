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
            # cls = self.get_class
            # Adapter::Exception.required_keys?(@config, cls.required)
         rescue Agave::Error::InvalidDriverKey => e
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

      def self.get_class()
         case @config[:driver]
         when 'sqlite'
            return SQLite
         when 'mysql'
            return MySQL
         when 'pgsql'
            return PostgreSQL
         else
            return false
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
             raise Error::InvalidDriverKey unless config.key? key
             exit
         end

         def self.required_keys?(config, required)
            required.each do |k|
              raise Error::RequiredDriverKey if config[k] == nil
            end
         end

      end #CLASS: Adapter::Exception
  end #MODULE: Adapter


  class AdapterConnection
     include Adapter

     class << self

        def connect(&block)
           begin
              Adapter.set_driver(self.to_s)
              block.call(Agave::Adapter)
              Adapter::Exception.required_keys? Adapter.config, @required
              conn = Agave::Connection.new Adapter.config
              Adapter.clear
              conn
           rescue Agave::Error::RequiredDriverKey => e
              puts e.message self.to_s, @required
           end
         end

        attr_reader :required

     end #CLASS : self

  end #CLASS : AdapterConnection


   class SQLite < AdapterConnection
      @required = [:database]
   end #CLASS : SQLite

   class MySQL < AdapterConnection
      @required = [:host, :database, :username, :password]
   end #CLASS: MySQL

   class PostgreSQL < AdapterConnection
      @required = [:host, :database, :username, :password]
   end #CLASS: PostreSQL

end # MODULE:Agave
