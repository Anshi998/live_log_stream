require 'demo_project/sse'
require 'demo_project/log_file'
class LiveLogsController < ApplicationController
  include ActionController::Live
  def log
    response.headers['Content-Type'] = "text/event-stream"
    response.headers['Last-Modified'] = Time.now.httpdate
    sse = DemoProject::SSE.new(response.stream)
    log_file_path = Rails.root.join('log/development.log').to_s
    file = DemoProject::LogFile.new
    Filewatcher.new([log_file_path]).watch do |_file_path,event_type|
      next unless event_type.to_s.eql?('updated')
      lines = file.line_add(log_file_path)
      sse.write(lines)
    end
    # 10.times {
    #   sse.write "Hello World"
    #
    #   sleep 0.5
    # }
    sse.close
  end
end