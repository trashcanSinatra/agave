module Agave
   class Connection

      attr_reader :host, :database, :username, :password

      def initialize(config)
         params config[:host], config[:database], config[:username], config[:password]
         case config[:driver]
         when 'sqlite'
            puts @database
            conn = SQLite3::Database.open "#{@database}"
            Agave::Query.make conn
         when 'mysql'
            conn = Mysql2::Client.new(:host => @host,
                                      :database => @database,
                                      :username => @username,
                                      :password => @password
                                      )
            Agave::Query.make conn
         when 'pgsql'
            Agave::Query.make config
         end
      end  # END: Function Initialize

      private

      def params(host, database, username, password)
         @host=host
         @database=database
         @username=username
         @password=password
      end  # Function Set Connection Instance

   end  # END: Class Connection
end  # END: Module Agave
