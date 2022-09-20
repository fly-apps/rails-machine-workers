module ApplicationHelper
  def code_tag(file, lines=nil)
    content_tag :pre do
      content_tag :code do
        read_code file: file, lines: lines
      end
    end
  end

  private
    def read_code(file:, lines: nil)
      lines = (lines.min - 1)..(lines.max - 1)
      body = File.read Rails.root.join file
      lines ? body.lines[lines].join : body
    end
end
