module DemoProject
  class LogFile
    def line_add(filepath)
      content = File.open(file_path).readlines
      content.last(10)

    end
  end
end