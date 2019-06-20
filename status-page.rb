require "thor"
require_relative "libs/spider"
require_relative "libs/data_store"

class StatusPage < Thor
  desc "pull", "pull all the status page data from different providers and save to data store"
  def pull
  end

  desc "live", "constantly query the URLs and output the status periodically on the console and save to data store"
  def live
  end

  desc "history", "display all the data which was gathered in the data store"
  def history
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
