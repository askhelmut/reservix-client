module Reservix
  class ResponseError < HTTParty::ResponseError
    STATUS_CODES = {
      400 => "Bad Request",
      403 => "Forbidden",
      404 => "Not Found",
      412 => "Precondition Failed",
      500 => "Internal Server Error",
      501 => "Not Implemented"
    }

    def message
      error = response.parsed_response
      "HTTP status: #{response.code} #{STATUS_CODES[response.code]} Error: #{error}"
    rescue
      "HTTP status: #{response.code} #{STATUS_CODES[response.code]}"
    end

  end
end
