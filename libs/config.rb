require "yaml"

class Config
  FILEPATH = "config/setup.yml"

  def initialize(scope = nil)
    @yaml  = File.exist?(FILEPATH) ? YAML.load_file(FILEPATH) : {}
    @yaml  = {} unless @yaml
    @scope = scope.to_s
  end

  def services
    services = @yaml["services"] || []
    if ! @scope.empty? && services.map { |s| s["name"].downcase == @scope.downcase }.any?
      services = services.map.select { |service| service["name"].downcase == @scope.downcase }
    end
    services
  end

  def interval
    @yaml["interval"] || 3
  end
end
