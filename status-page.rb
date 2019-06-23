require "thor"
require_relative "libs/config"
require_relative "libs/spider"
require_relative "libs/data_store"
require_relative "libs/presenter"
require_relative "libs/stats"

class StatusPage < Thor

  desc "pull", "pull all the status page data from different providers and save to data store"
  def pull(scope = nil)
    config    = Config.new(scope)
    store     = DataStore.new
    presenter = Presenter.new

    statuses = Spider.pull(config.services)
    store.save(statuses)
    print presenter.header
    print presenter.show(statuses)
  end

  desc "live", "constantly query the URLs and output the status periodically on the console and save to data store"
  def live(scope = nil)
    begin
      config    = Config.new(scope)
      store     = DataStore.new
      presenter = Presenter.new
      print presenter.header
      loop do
        statuses = Spider.pull(config.services)
        store.save(statuses)
        print presenter.show(statuses)
        sleep(config.interval)
      end
    rescue Exception => e
      p "You've interrupted the live pulling!"
    end
  end

  desc "history", "display all the data which was gathered in the data store"
  def history
    presenter = Presenter.new
    print presenter.header
    DataStore.foreach do |row|
      print presenter.show([row])
    end
  end

  desc "stats", "display summarized data in the log"
  def stats
    config     = Config.new
    presenter  = Presenter.new
    data       = DataStore.read_all
    stats_data = Stats.summarize(config.services, data)
    print presenter.header_stats
    stats_data.each do |row|
      print presenter.show_stats([row])
    end
  end

  desc "backup [PATH]", "creates a backup of historic and currently data"
  def backup(path)
    DataStore.backup(path)
  end

  desc "restore [PATH]", "restore data based on the backup"
  def restore(path)
    DataStore.restore(path)
  end
end
