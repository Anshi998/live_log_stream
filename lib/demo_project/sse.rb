require 'json'
module DemoProject
  class SSE
    def initialize(io)
      @io = io
    end
    def write(lines)
      lines.each do |line|
        @io.write line
      end
    end
    def close
      @io.close
    end
  end
end