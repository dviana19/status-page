require "yaml"

class Config
  FILEPATH = "config/setup.yml"

  def initialize
    @yaml = File.exist?(FILEPATH) ? YAML.load_file(FILEPATH) : {}
    @yaml = {} unless @yaml
  end

  def services
    @yaml["services"] || []
  end

  def interval
    @yaml["interval"] || 3
  end
end
