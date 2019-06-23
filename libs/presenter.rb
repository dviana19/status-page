require "command_line_reporter"

class Presenter
  include CommandLineReporter

  BORDER = true
  COLOR  = "green"
  BOLD   = true
  WIDTH  = {service: 20, status: 10, message: 25, time: 20, duration: 50}
  ALIGN  = "right"

  def header
    suppress_output

    table(border: BORDER) do
      row color: COLOR, bold: BOLD do
        column('Service', width: WIDTH[:service])
        column('Status', width: WIDTH[:status])
        column('Message', width: WIDTH[:message])
        column('Time', width: WIDTH[:time], align: ALIGN)
      end
    end
    return capture_output
  end

  def header_stats
    suppress_output

    table(border: BORDER) do
      row color: COLOR, bold: BOLD do
        column('Service', width: WIDTH[:service])
        column('Up since', width: WIDTH[:duration])
        column('Down time', width: WIDTH[:duration])
      end
    end
    return capture_output
  end

  def show(data)
    suppress_output

    table(border: BORDER) do
      data.each do |record|
        row do
          column(record[0], width: WIDTH[:service])
          column(record[1], width: WIDTH[:status])
          column(record[2], width: WIDTH[:message])
          column(Time.at(record[3].to_i).strftime("%d.%m.%Y %T"), width: WIDTH[:time], align: ALIGN)
        end
      end
    end
    return capture_output
  end

  def show_stats(data)
    suppress_output

    table(border: BORDER) do
      data.each do |record|
        row do
          column(record[0], width: WIDTH[:service])
          column(record[1], width: WIDTH[:duration])
          column(record[2], width: WIDTH[:duration])
        end
      end
    end
    return capture_output
  end
end
