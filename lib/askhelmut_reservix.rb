require 'hashie'
require 'httmultiparty'
require 'uri'

require 'askhelmut-reservix/client'
require 'askhelmut-reservix/version'

module AskhelmutReservix

  def new(options={})
    Client.new(options)
  end
  module_function :new

  def method_missing(method_name, *args, &block)
    return super unless respond_to_missing?(method_name)
    Client.send(method_name, *args, &block)
  end
  module_function :method_missing

  def respond_to_missing?(method_name, include_private=false)
    Client.respond_to?(method_name, include_private)
  end
  module_function :respond_to_missing?

end

AskHelmutReservix = AskhelmutReservix
