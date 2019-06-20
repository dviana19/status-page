require "csv"
require "fileutils"

class DataStore
  PATH = "data"
  FILE = "store.csv"

  class << self
    def open
      mode = "wb"
      if File.exist?("#{PATH}/#{FILE}")
        mode = "ab"
      end
      CSV.open("#{PATH}/#{FILE}", mode)
    end

    def read
      CSV.foreach("#{PATH}/#{FILE}") do |row|
        yield(row[0], row[1], Time.at(row[2].to_i))
      end
    end

    def backup(given_path)
      FileUtils.cp("#{PATH}/#{FILE}", "#{given_path}/#{FILE}.bkp")
    end

    def restore(given_path)
      FileUtils.cp("#{given_path}/#{FILE}.bkp", "#{PATH}/#{FILE}")
    end

    private

    def copy(src, dest)
      FileUtils.cp(src, dest)
    end
  end
end
