require "time_difference"
class Stats

  def self.summarize(services, data)
    statuses    = []
    services.each do |service|
      name  = service["name"]
      rows  = data.select { |s| s[0] == name }

      last_down  = rows.rindex { |s| s[1] == "Down" } || - 1
      up_indexes = rows.map.each_with_index { |v, k| k if v[1] == "Up" }.compact

      if up_indexes.empty?
        up_result = "No uptime"
      else
        ups = rows.slice(last_down + 1, up_indexes.length).first
        up_result = TimeDifference.between(Time.at(ups[3].to_i), Time.now).humanize.downcase
      end

      find_down   = true
      find_up     = false
      found_index = []
      rows.each_with_index do |row, i|
        if find_down && row[1] == "Down"
          found_index << [i, "Down", row[3]]
          find_down = false
          find_up   = true
        elsif find_up && row[1] == "Up"
          found_index << [i, "Up", row[3]]
          find_down = true
          find_up   = false
        end
      end

      if found_index.size == 0
        down_result = "No down time"
      else
        if found_index.size % 2 != 0
          found_index << [found_index.size + 1, "-", Time.now]
        end

        diff = 0
        found_index.each_with_index do |found, i|
          if ! found_index[i + 1].nil?
            diff += TimeDifference.between(Time.at(found[2].to_i), Time.at(found_index[i+1][2].to_i)).in_seconds
          end
        end
        down_result = translate_time(diff)
      end

      statuses << [name, up_result, down_result]
    end
    statuses
  end

  private

  def self.translate_time(diff)
    result = {
      minute: ((diff / 60) % 60).round,
      hour: (diff / (60 * 60)).round,
      day: (diff / (60 * 60 * 24)).round
    }.delete_if { |k, v| v == 0 }.min_by{|k, v| v}

    result.nil? ? "No down time" : "#{result.last} #{result.first}#{result.last > 1 ? 's' : ''}"
  end
end
