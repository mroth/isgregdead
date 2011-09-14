module MainHelper

  def dead_msg(time)
    return case
    when time > 2.hours.ago
      'NO WAY'
    when time > 6.hours.ago
      'EXTREMELY UNLIKELY'
    when time > 24.hours.ago
      'DOUBTFUL'
    when time > 3.days.ago
      'POSSIBLY'
    else
      'CALL THE COPS?!'
    end
  end

end
