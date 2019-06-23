require "thor"
require_relative "libs/config"
require_relative "libs/spider"
require_relative "libs/data_store"
require_relative "libs/presenter"

class StatusPage < Thor

  desc "pull", "pull all the status page data from different providers and save to data store"
  def pull
    store     = DataStore.new
    config    = Config.new
    presenter = Presenter.new

    statuses = Spider.pull(config.services)
    store.save(statuses)
    print presenter.header
    print presenter.show(statuses)
  end

  desc "live", "constantly query the URLs and output the status periodically on the console and save to data store"
  def live
    begin
      store     = DataStore.new
      config    = Config.new
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
    DataStore.read do |row|
      print presenter.show([row])
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

StatusPage.start(ARGV)
