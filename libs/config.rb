require 'yaml'
class Config
  FILEPATH = "config/services.yml"

  def initialize
    @yaml = YAML.load_file(FILEPATH)
  end

  def services
    @yaml["services"] || []
  end

  def interval
    @yaml["interval"] || 3
  end
end
