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
      message = get_status_message(service["address"])
      statuses << [service["name"], get_status_from_message(message), message, Time.now.to_i]
    end
    statuses
  end

  private

  def get_status_message(page_address)
    parser  = Oga.parse_html(open(page_address))
    content = parser.at_css(".page-status .status")
    content.nil? ? "Status unknown" : content.text.strip
  rescue Exception => e
    e.message
  end

  def get_status_from_message(message)
    message == "All Systems Operational" ? "Up" : "Down"
  end
end
