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

        def set(url_string)
          @connection_string = url_string
        end

        def get
          @connection_string
        end

        def fetch
          return get if get
          return ENV["DATABASE_URL"] if ENV["DATABASE_URL"]
          raise RuntimeError.new(
            <<~HEREDOC
              Sequel::Rake requires that a connection url string be set.
              define 'DATABASE_URL' in your environment or call Sequel::Rake.configure.
              For Example,

                Sequel::Rake.configure do
                  set :connection, ENV['DATABASE_URL']
                  set :migrations, "#{__dir__}/lib/db/migrations"
                  set :namespace, "db"
                end
            HEREDOC
          )
        end
      end
    end

    class << self
      def configuration
        @configuration ||= {
          connection: Rake::Connection.fetch,
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
