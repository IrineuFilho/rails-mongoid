# frozen_string_literal: true

module Queries
  class LocaleQuery
    class << self
      def call(name)
        City.where({ name: /#{name}/i })
      end
    end
  end
end
