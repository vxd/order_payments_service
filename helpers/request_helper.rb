# frozen_string_literal: true

module RequestHelper
  def parse_request_body(body)
    JSON.parse(body)
  rescue JSON::ParserError
    halt 400, { error: "Bad request. Can't parse JSON" }.to_json
  end
end
