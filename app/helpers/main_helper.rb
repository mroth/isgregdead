module MainHelper

  def dead_msg(time)
    return case
    when time < 2.hours.ago
      'HIGHLY UNLIKELY'
    when time < 6.hours.ago
      'DUBIOUS'
    when time < 24.hours.ago
      "LET'S SAY... NO"
    when time < 3.days.ago
      'ARGUABLY'
    else
      'CALL THE COPS!!'
    end
  end

end
