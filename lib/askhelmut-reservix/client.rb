module AskhelmutReservix
  class Client
    include HTTMultiParty
    USER_AGENT = "ASK HELMUT Rerservix API Wrapper #{VERSION}"
    CLIENT_ID_PARAM_NAME = :client_id
    API_SUBHOST = 'api'
    API_VERSION = '1'
    DEFAULT_OPTIONS = {
      site: 'reservix.de',
      use_ssl: true
    }

    attr_accessor :options
    headers({"User-Agent" => USER_AGENT})

    def initialize(options = {})
      store_options(options)
      raise ArgumentError, "An api key must be present" if api_key.nil?
    end

    # accessors for options
    def api_key
      @options[:api_key]
    end

    def use_ssl?
      @options[:use_ssl]
    end

    def site
      @options[:site]
    end
    alias host site

    def api_host
      [API_SUBHOST, host].join('.')
    end

    private
      def store_options(options={})
        @options ||= DEFAULT_OPTIONS.dup
        @options.merge!(options)
      end
  end
end
