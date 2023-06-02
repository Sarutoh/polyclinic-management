# frozen_string_literal: true

class BasePresenter
  def initialize(**params)
    @params = params
  end

  def call
    params.each do |method, value|
      @result = public_send(method, value)
    end

    result
  end

  def self.call(*args, **kvargs)
    new(*args, **kvargs).call
  end

  private

  attr_reader :params, :result
end
