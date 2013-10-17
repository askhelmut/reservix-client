module AskhelmutReservix
  class Client
    include HTTMultiParty
    USER_AGENT = "ASK HELMUT Reservix API Wrapper #{VERSION}"
    API_KEY_PARAM_NAME = "api-key"
    API_SUBHOST = "api"
    API_VERSION = "1"
    DEFAULT_OPTIONS = {
      site: "reservix.de",
      use_ssl: true,
      api_module: "sale"
    }

    attr_accessor :options
    headers({"User-Agent" => USER_AGENT})

    def initialize(options = {})
      store_options(options)
      raise ArgumentError, "An api key must be present" if api_key.nil?
    end

    def get(path, query={}, options={})
      handle_response {
        self.class.get(*construct_query_arguments(path, options.merge(:query => query)))
      }
    end

    def post(path, body={},  options={})
      handle_response {
        self.class.post(*construct_query_arguments(path, options.merge(:body => body), :body))
      }
    end

    def put(path, body={},  options={})
      handle_response {
        self.class.put(*construct_query_arguments(path, options.merge(:body => body), :body))
      }
    end

    def delete(path, query={}, options={})
      handle_response {
        self.class.delete(*construct_query_arguments(path, options.merge(:query => query)))
      }
    end

    def head(path, query={}, options={})
      handle_response {
        self.class.head(*construct_query_arguments(path, options.merge(:query => query)))
      }
    end

    # accessors for options
    def api_key
      @options[:api_key]
    end

    def use_ssl?
      @options[:use_ssl]
    end

    def api_module
      @options[:api_module]
    end

    def site
      @options[:site]
    end
    alias host site

    def api_host
      [API_SUBHOST, host].join(".")
    end

    def api_url
      [api_host, API_VERSION, api_module].join("/")
    end
    private

      def handle_response(refreshing_enabled=true, &block)
        response = block.call
        if response && !response.success?
          raise ResponseError.new(response)
        elsif response.is_a?(Hash)
          HashResponseWrapper.new(response)
        # elsif response.is_a?(Array)
        #   ArrayResponseWrapper.new(response)
        elsif response && response.success?
          response
        end
      end

      def store_options(options={})
        @options ||= DEFAULT_OPTIONS.dup
        @options.merge!(options)
      end

      def construct_query_arguments(path_or_uri, options={}, body_or_query=:query)
        uri = URI.parse(path_or_uri)
        path = uri.path
        scheme = use_ssl? ? "https" : "http"
        options = options.dup
        puts options
        options[body_or_query] ||= {}
        options[body_or_query][:format] = "json"
        options[body_or_query][API_KEY_PARAM_NAME] = api_key

        [
          "#{scheme}://#{api_url}#{path}#{uri.query ? "?#{uri.query}" : ""}",
          options
        ]
      end
  end
end
