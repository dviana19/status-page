require "thor"

class StatusPage < Thor
  desc "pull", "pull all the status page data from different providers and save to data store"
  def pull
    puts __method__
  end

  desc "live", "constantly query the URLs and output the status periodically on the console and save to data store"
  def live
    puts __method__
  end

  desc "history", "display all the data which was gathered in the data store"
  def history
    puts __method__
  end

  desc "backup [PATH]", "creates a backup of historic and currently data"
  def backup(path)
    puts __method__
  end

  desc "restore [PATH]", "restore data based on the backup"
  def restore(path)
    puts __method__
  end
end

StatusPage.start(ARGV)
