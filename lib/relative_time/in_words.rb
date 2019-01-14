module RelativeTime
  class InWords
    def call(date_to, date_from)
      diff = date_from.to_time - date_to.to_time
      return '1分钟前' if diff.abs.round <= 59

      date_string = verb_agreement(resolution(diff.abs.round))
      diff >= 0 ? "#{date_string} 前" : "#{date_string}"
    end

  private
    MINUTE = 60
    HOUR   = 60 * MINUTE
    DAY    = 24 * HOUR
    WEEK   = 7  * DAY
    MONTH  = 4  * WEEK
    YEAR   = 12 * MONTH

    def resolution(diff)
      if diff >= YEAR
        [(diff / YEAR).round, '年']
      elsif diff >= MONTH
        [(diff / MONTH).round, '月']
      elsif diff >= WEEK
        [(diff / WEEK).round, '周']
      elsif diff >= DAY
        [(diff / DAY).round, '天']
      elsif diff >= HOUR
        [(diff / HOUR).round, '小时']
      else
        [(diff / MINUTE).round, '分钟']
      end
    end

    def verb_agreement(resolution)
      if resolution[0] == 1 && resolution.last == '小时'
        '小时'
      elsif resolution[0] == 1
        resolution.last[0...-1]
      else
        resolution.join(' ')
      end
    end
  end
end
