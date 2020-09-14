require_relative 'time_service' 

class App

  def call(env)
    request = Rack::Request.new(env)

    params = if request.path_info == '/time'
      request_time(request.params)
    else
      # response_compose(404, "Unknown resource '#{request.path_info}'\n")
      request_404
    end
  end

  private

  def request_404
    [404, headers, ["Unknown resource.\n\n"]]
  end

  # def response_compose(status, text)
  #   @response = Rack::Response.new
  #   @response.status = status
  #   @response.write "#{text}"
  #   @response.headers['Content-Type'] = 'text/plain'
  #   @response.finish
  # end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def request_time(params)
    time = TimeService.new(params)
    body = [time.result.join("\n") + "\n\n"]

    if time.success?
      [200, headers, body]
    else
      [400, headers, body]
    end
  end
end
