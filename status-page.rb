require "thor"
require "oga"
require "open-uri"
require_relative "libs/data_store"

class StatusPage < Thor
  desc "pull", "pull all the status page data from different providers and save to data store"
  def pull

    csv = DataStore.open

    pages.each do |page|
      parser = Oga.parse_html(open(page))
      content = parser.at_css(".page-status .status").text.strip
      csv << [content, page, Time.now.to_i]
    end

  end

  desc "live", "constantly query the URLs and output the status periodically on the console and save to data store"
  def live
    begin

      loop do
        pages.each do |page|
          parser = Oga.parse_html(open(page))
          content = parser.at_css(".page-status .status").text.strip
          puts content.inspect
        end
        sleep 3
      end

    rescue Exception => e
      puts "interrupted!"
    end

  end

  desc "history", "display all the data which was gathered in the data store"
  def history
    puts "Service           status            Time"
    DataStore.read do |service, status, time|
      puts service
      puts status
      puts time
      puts "---------"
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
  def pages
    [
      "https://bitbucket.status.atlassian.com/",
      "https://www.cloudflarestatus.com/",
      "https://status.rubygems.org/",
      "https://www.githubstatus.com/"
    ]
  end
end

StatusPage.start(ARGV)
