# frozen_string_literal: true

require_relative "rake/version"

module Sequel
  #
  # @example
  #   Sequel::Rake.configure do
  #     set :connection, ENV["DATABASE_URL"]
  #     set :migrations, "#{__dir__}/lib/db/migrations"
  #     set :namespace, "db"
  #   end
  #
  module Rake
    module Connection
      class << self
        def connection_url
          @connection_url
        end

        def set_connection_url(connection_url)
          @connection_url = connection_url
        end

        def fetch
          return connection_url if connection_url
          return ENV["DATABASE_URL"] if ENV["DATABASE_URL"]
          raise RuntimeError.new("""
            Sequel::Rake requires that a connection url string be set.
            This can be done either by using Rake::Connection.set_connection_url(url_string),
            or by defining 'DATABASE_URL' in your environment
            """
          )
        end
      end
    end

    class << self
      def configuration
        @configuration ||= {
          connection: Sequel::Rake::Connection.fetch,
          migrations: "db/migrations",
          namespace: "sequel"
        }
      end

      def configure(&block)
        instance_eval(&block)
      end

      def set(key, value)
        configuration[key] = value
      end

      def get(key)
        configuration.fetch(key)
      end

      def load!
        load "#{__dir__}/rake/tasks.rake"
      end
    end
  end
end
