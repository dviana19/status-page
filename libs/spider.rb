require "oga"
require "open-uri"

class Spider
  def initialize(services)
    @services = services
  end

  def self.pull(attrs)
    new(attrs).pull
  end

  def pull
    statuses = []
    @services.each do |service|
      statuses << [service["name"], get_status_content(service["address"]), Time.now.to_i]
    end
    statuses
  end

  private

  def get_status_content(page_address)
    parser  = Oga.parse_html(open(page_address))
    content = parser.at_css(".page-status .status")
    content.nil? ? "Status unknown" : content.text.strip
  rescue Exception => e
    e.message
  end
end
