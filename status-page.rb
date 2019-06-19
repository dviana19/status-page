require "thor"
require "oga"
require "open-uri"
require "csv"
require "fileutils"

class StatusPage < Thor
  desc "pull", "pull all the status page data from different providers and save to data store"
  def pull

    #f = File.new("data/testfile.log", "w+")
    csv = CSV.open("data/testfile.csv", "wb")

    pages.each do |page|
      parser = Oga.parse_html(open(page))
      content = parser.at_css(".page-status .status").text.strip
      csv << [Time.now.to_i, content, page]
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

    CSV.foreach("data/testfile.csv") do |row|
      puts Time.at(row[0].to_i)
      puts row[1]
      puts row[2]
      puts "---------"
    end

  end

  desc "backup [PATH]", "creates a backup of historic and currently data"
  def backup(path)
    FileUtils.cp("data/testfile.csv", "#{path}/testfile.csv.bkp")
  end

  desc "restore [PATH]", "restore data based on the backup"
  def restore(path)
    FileUtils.cp("#{path}/testfile.csv.bkp", "data/testfile.csv")
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
