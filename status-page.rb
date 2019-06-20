require "thor"
require "command_line_reporter"
require_relative "libs/config"
require_relative "libs/spider"
require_relative "libs/data_store"

class StatusPage < Thor
  include CommandLineReporter

  desc "pull", "pull all the status page data from different providers and save to data store"
  def pull
    store  = DataStore.open
    config = Config.new
    present(store, config)
  end

  desc "live", "constantly query the URLs and output the status periodically on the console and save to data store"
  def live
    begin
      store  = DataStore.open
      config = Config.new
      loop do
        present(store, config)
        sleep(config.interval)
      end
    rescue Exception => e
      p "Bye!!!"
    end
  end

  desc "history", "display all the data which was gathered in the data store"
  def history
    table(border: true) do
      row do
        column('Service', width: 20)
        column('Status', width: 30)
        column('Time', width: 50, align: 'right', padding: 5)
      end
      DataStore.read do |service, status, time|
        row do
          column(service)
          column(status)
          column(time)
        end
      end
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

  private

  def present(store, config)
    config.services.each do |service|
      status = Spider.new(service["address"]).get_status_content
      data   = [service["name"], status, Time.now.strftime("%d.%m.%Y %T")]
      p data.join(" -- ")
      store << data
    end
  end

end

StatusPage.start(ARGV)
