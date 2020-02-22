# frozen_string_literal: true

module Exceptions
  class BadRequestException < StandardError
    attr_reader :errors

    def initialize(errors = [])
      @errors = errors
    end
  end
end
