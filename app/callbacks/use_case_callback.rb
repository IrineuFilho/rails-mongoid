module Callbacks
  class UseCaseCallback

    def self.success(object = nil)
      UseCaseCallback.new(:success, object)
    end

    def self.fail(object = nil)
      UseCaseCallback.new(:fail, object)
    end

    def on_success
      yield(object) if block_given? && status == :success
    end

    def on_fail
      yield(object) if block_given? && status == :fail
    end

    private

    attr_reader :status, :object

    def initialize(status, object)
      @status = status
      @object = object
    end

  end
end
