module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end

  def mock_request(response_body)
    last_modified = Date.new(2010, 1, 15).to_s
    content_length = '1024'
    request_object = HTTParty::Request.new Net::HTTP::Get, '/'
    response_object = Net::HTTPOK.new('1.1', 200, 'OK')
    allow(response_object).to receive_messages(body: response_body)
    response_object['last-modified'] = last_modified
    response_object['content-length'] = content_length
    parsed_response = lambda { JSON.parse(response_body) }
    HTTParty::Response.new(request_object, response_object, parsed_response)
  end
end
