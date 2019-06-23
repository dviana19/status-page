require "command_line_reporter"

class Presenter
  include CommandLineReporter

  BORDER = true
  COLOR  = "green"
  BOLD   = TRUE
  WIDTH  = {service: 20, status: 30, time: 25}
  ALIGN  = "right"

  def header
    suppress_output

    table(border: BORDER) do
      row color: COLOR, bold: BOLD do
        column('Service', width: WIDTH[:service])
        column('Status', width: WIDTH[:status])
        column('Time', width: WIDTH[:time], align: ALIGN)
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
          column(Time.at(record[2].to_i).strftime("%d.%m.%Y %T"), width: WIDTH[:time], align: ALIGN)
        end
      end
    end
    return capture_output
  end
end
