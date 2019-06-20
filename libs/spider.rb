require "oga"
require "open-uri"
require "command_line_reporter"
require_relative "data_store"

class Spider
  def initialize(page)
    @parser = Oga.parse_html(open(page))
  end

  def get_status_content
    content = @parser.at_css(".page-status .status")
    content.nil? ? "Invalid response" : content.text.strip
  end
end
