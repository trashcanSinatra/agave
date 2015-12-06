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
            unless Error::DriverKey.check? key, @config
               @config[key] = val
            end
         end
      rescue Agave::Error::Standard => e
         puts e.message key, @config
      end
   end # METHOD: option

   def self.clear
      @config.map do |k,v|
         @config[k] = k == :charset ? 'utf8' : nil
      end
   end

   def self.config
    @config
   end


  end # MODULE: Adapter


   class SQLite
      include Adapter
      @config

      class << self

         def connect(&block)
            Adapter.set :driver, 'sqlite'
            block.call(Agave::Adapter)
            conn = Agave::Connection.new Adapter.config
            Adapter.clear
         end

      end # CLASS : self

   end # CLASS : SQLite


   class MySQL
      include Adapter
      @config

      class << self

         def connect(&block)
            Adapter.set :driver, 'mysql'
            block.call(Agave::Adapter)
            conn = Agave::Connection.new Adapter.config
            Adapter.clear
         end

      end # CLASS:self
   end # CLASS:MySQL

   class PostgreSQL
      include Adapter
      @config

      class << self

         def connect(&block)
            Adapter.set :driver, 'postgre'
            block.call(Agave::Adapter)
            conn = Agave::Connection.new Adapter.config
            Adapter.clear
         end

      end # CLASS:self
   end # CLASS:PostreSQL

end # MODULE:Agave
