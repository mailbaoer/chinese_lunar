# encoding: utf-8
# Modify from http://my.oschina.net/tomsu/blog/700

module ChineseLunar
  class Lunar

    @@lunar_info = [0x04bd8, 0x04ae0, 0x0a570,
                    0x054d5, 0x0d260, 0x0d950, 0x16554, 0x056a0, 0x09ad0, 0x055d2,
                    0x04ae0, 0x0a5b6, 0x0a4d0, 0x0d250, 0x1d255, 0x0b540, 0x0d6a0,
                    0x0ada2, 0x095b0, 0x14977, 0x04970, 0x0a4b0, 0x0b4b5, 0x06a50,
                    0x06d40, 0x1ab54, 0x02b60, 0x09570, 0x052f2, 0x04970, 0x06566,
                    0x0d4a0, 0x0ea50, 0x06e95, 0x05ad0, 0x02b60, 0x186e3, 0x092e0,
                    0x1c8d7, 0x0c950, 0x0d4a0, 0x1d8a6, 0x0b550, 0x056a0, 0x1a5b4,
                    0x025d0, 0x092d0, 0x0d2b2, 0x0a950, 0x0b557, 0x06ca0, 0x0b550,
                    0x15355, 0x04da0, 0x0a5d0, 0x14573, 0x052d0, 0x0a9a8, 0x0e950,
                    0x06aa0, 0x0aea6, 0x0ab50, 0x04b60, 0x0aae4, 0x0a570, 0x05260,
                    0x0f263, 0x0d950, 0x05b57, 0x056a0, 0x096d0, 0x04dd5, 0x04ad0,
                    0x0a4d0, 0x0d4d4, 0x0d250, 0x0d558, 0x0b540, 0x0b5a0, 0x195a6,
                    0x095b0, 0x049b0, 0x0a974, 0x0a4b0, 0x0b27a, 0x06a50, 0x06d40,
                    0x0af46, 0x0ab60, 0x09570, 0x04af5, 0x04970, 0x064b0, 0x074a3,
                    0x0ea50, 0x06b58, 0x055c0, 0x0ab60, 0x096d5, 0x092e0, 0x0c960,
                    0x0d954, 0x0d4a0, 0x0da50, 0x07552, 0x056a0, 0x0abb7, 0x025d0,
                    0x092d0, 0x0cab5, 0x0a950, 0x0b4a0, 0x0baa4, 0x0ad50, 0x055d9,
                    0x04ba0, 0x0a5b0, 0x15176, 0x052b0, 0x0a930, 0x07954, 0x06aa0,
                    0x0ad50, 0x05b52, 0x04b60, 0x0a6e6, 0x0a4e0, 0x0d260, 0x0ea65,
                    0x0d530, 0x05aa0, 0x076a3, 0x096d0, 0x04bd7, 0x04ad0, 0x0a4d0,
                    0x1d0b6, 0x0d250, 0x0d520, 0x0dd45, 0x0b5a0, 0x056d0, 0x055b2,
                    0x049b0, 0x0a577, 0x0a4b0, 0x0aa50, 0x1b255, 0x06d20, 0x0ada0]

    @@nstr       = ["", "正", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二"]
    @@gan        = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"]
    @@zhi        = ["子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"]
    @@nnimals    = ["鼠", "牛", "虎", "兔", "龙", "蛇", "马", "羊", "猴", "鸡", "狗", "猪"]
    @@solar_term = ['小寒', '大寒', '立春', '雨水', '惊蛰', '春分', '清明', '谷雨', '立夏', '小满', '芒种', '夏至', '小暑', '大暑', '立秋', '处暑', '白露', '秋分', '寒露', '霜降', '立冬', '小雪', '大雪','冬至']
    @@term_info  = [0,21208,42467,63836,85337,107014,128867,150921,173149,195551, 218072,240693,263343,285989,308563,331033,353350,375494,397447,419210,440795,462224,483532,504758];

    @@solar_festival = {
    'd0101' => '元旦节',
    'd0214' => '情人节',
    'd0308' => '妇女节',
    'd0312' => '植树节',
    'd0401' => '愚人节',
    'd0501' => '劳动节',
    'd0504' => '青年节',
    'd0601' => '儿童节',
    'd0801' => '建军节',
    'd0910' => '教师节', 
    'd1001' => '国庆节',
    'd1006' => '老人节',
    'd1224' => '平安夜',
    'd1225' => '圣诞节'
  }

  @@lunar_festival = {
    'd0101' => '春节',
    'd0115' => '元宵节',
    'd0505' => '端午',
    'd0707' => '七夕',
    'd0815' => '中秋节',
    'd0909' => '重阳节',
    'd1208' => '腊八节',
    'd1223' => '小年',
    'd0100' => '除夕'
  }

  @@lunar_new_info = [[2,1,21,22184],[0,2,9,21936],[6,1,30,9656],[0,2,17,9584],[0,2,6,21168],[5,1,26,43344],[0,2,13,59728],[0,2,2,27296],[3,1,22,44368],[0,2,10,43856],[8,1,30,19304],[0,2,19,19168],[0,2,8,42352],[5,1,29,21096],[0,2,16,53856],[0,2,4,55632],[4,1,25,27304],[0,2,13,22176],[0,2,2,39632],[2,1,22,19176],[0,2,10,19168],[6,1,30,42200],[0,2,18,42192],[0,2,6,53840],[5,1,26,54568],[0,2,14,46400],[0,2,3,54944],[2,1,23,38608],[0,2,11,38320],[7,2,1,18872],[0,2,20,18800],[0,2,8,42160],[5,1,28,45656],[0,2,16,27216],[0,2,5,27968],[4,1,24,44456],[0,2,13,11104],[0,2,2,38256],[2,1,23,18808],[0,2,10,18800],[6,1,30,25776],[0,2,17,54432],[0,2,6,59984],[5,1,26,27976],[0,2,14,23248],[0,2,4,11104],[3,1,24,37744],[0,2,11,37600],[7,1,31,51560],[0,2,19,51536],[0,2,8,54432],[6,1,27,55888],[0,2,15,46416],[0,2,5,22176],[4,1,25,43736],[0,2,13,9680],[0,2,2,37584],[2,1,22,51544],[0,2,10,43344],[7,1,29,46248],[0,2,17,27808],[0,2,6,46416],[5,1,27,21928],[0,2,14,19872],[0,2,3,42416],[3,1,24,21176],[0,2,12,21168],[8,1,31,43344],[0,2,18,59728],[0,2,8,27296],[6,1,28,44368],[0,2,15,43856],[0,2,5,19296],[4,1,25,42352],[0,2,13,42352],[0,2,2,21088],[3,1,21,59696],[0,2,9,55632],[7,1,30,23208],[0,2,17,22176],[0,2,6,38608],[5,1,27,19176],[0,2,15,19152],[0,2,3,42192],[4,1,23,53864],[0,2,11,53840],[8,1,31,54568],[0,2,18,46400],[0,2,7,46752],[6,1,28,38608],[0,2,16,38320],[0,2,5,18864],[4,1,25,42168],[0,2,13,42160],[10,2,2,45656],[0,2,20,27216],[0,2,9,27968],[6,1,29,44448],[0,2,17,43872],[0,2,6,38256],[5,1,27,18808],[0,2,15,18800],[0,2,4,25776],[3,1,23,27216],[0,2,10,59984],[8,1,31,27432],[0,2,19,23232],[0,2,7,43872],[5,1,28,37736],[0,2,16,37600],[0,2,5,51552],[4,1,24,54440],[0,2,12,54432],[0,2,1,55888],[2,1,22,23208],[0,2,9,22176],[7,1,29,43736],[0,2,18,9680],[0,2,7,37584],[5,1,26,51544],[0,2,14,43344],[0,2,3,46240],[4,1,23,46416],[0,2,10,44368],[9,1,31,21928],[0,2,19,19360],[0,2,8,42416],[6,1,28,21176],[0,2,16,21168],[0,2,5,43312],[4,1,25,29864],[0,2,12,27296],[0,2,1,44368],[2,1,22,19880],[0,2,10,19296],[6,1,29,42352],[0,2,17,42208],[0,2,6,53856],[5,1,26,59696],[0,2,13,54576],[0,2,3,23200],[3,1,23,27472],[0,2,11,38608],[11,1,31,19176],[0,2,19,19152],[0,2,8,42192],[6,1,28,53848],[0,2,15,53840],[0,2,4,54560],[5,1,24,55968],[0,2,12,46496],[0,2,1,22224],[2,1,22,19160],[0,2,10,18864],[7,1,30,42168],[0,2,17,42160],[0,2,6,43600],[5,1,26,46376],[0,2,14,27936],[0,2,2,44448],[3,1,23,21936],[0,2,11,37744],[8,2,1,18808],[0,2,19,18800],[0,2,8,25776],[6,1,28,27216],[0,2,15,59984],[0,2,4,27424],[4,1,24,43872],[0,2,12,43744],[0,2,2,37600],[3,1,21,51568],[0,2,9,51552],[7,1,29,54440],[0,2,17,54432],[0,2,5,55888],[5,1,26,23208],[0,2,14,22176],[0,2,3,42704],[4,1,23,21224],[0,2,11,21200],[8,1,31,43352],[0,2,19,43344],[0,2,7,46240],[6,1,27,46416],[0,2,15,44368],[0,2,5,21920],[4,1,24,42448],[0,2,12,42416],[0,2,2,21168],[3,1,22,43320],[0,2,9,26928],[7,1,29,29336],[0,2,17,27296],[0,2,6,44368],[5,1,26,19880],[0,2,14,19296],[0,2,3,42352],[4,1,24,21104],[0,2,10,53856],[8,1,30,59696],[0,2,18,54560],[0,2,7,55968],[6,1,27,27472],[0,2,15,22224],[0,2,5,19168],[4,1,25,42216],[0,2,12,42192],[0,2,1,53584],[2,1,21,55592],[0,2,9,54560]];

    attr_reader :Date

    def initialize(date = Date.today)
      @date = date
    end

    # Get Lundar date in Chinese text
    def lunar_date_in_chinese() 
      lunar_date  = convert(@date.year, @date.month, @date.day)
      solar_year  = cyclical_year(lunar_date[0]) + "年"
      solar_month = [lunar_date[6] == 1 ? '闰' : '', @@nstr[lunar_date[1]], "月"].join()
      solar_day   = get_day_in_chinese(lunar_date[2])

      {
        :year  => @date.year,
        :month => @date.month,
        :day   => @date.day,
        :wday  => @date.wday,
        :solar_year  => solar_year,
        :solar_month => solar_month,
        :solar_day   => solar_day,
        :lunar_festival => lunar_festival,
        :solar_festival => solar_festival
      }
    end

    def lunar_date_year_in_chinese()
      l = convert(@date.year, @date.month, @date.day)
      cyclical_year(l[0])
    end

    # Get the Lundar date in 'xxxx-xx-xx' fromat
    def lunar_date(year, month, day) 
      l = convert(year, month, day)
      l[0].to_s + "-" + l[1].to_s + "-" + (/^\d+/.match(l[2].to_s)).to_s
    end

    def lunar_year_term()
      res = {}
      month = 0
      (0..23).each do |i|
        day = get_term(@date.year, i)
        month += 1 if i % 2 == 0
        res[format_date(month - 1, day)] = @@solar_term[i]
      end
      res
    end

    def lunar_festival()
      lunar_date = lunar_by_between(@date.year, @date.month, @date.day)
      lunar_month_days = days_in_lunar_year(@date.year)[:month_days]
      lunar_leap_month = lunar_leap_year(@date.year)

      # 除夕
      #if lunar_date[1] == lunar_month_days.size - 1 && lunar_date[2] == lunar_month_days[lunar_month_days.size - 1]
      #  lunar_festival = @@lunar_festival['d0100']
      #els
      if lunar_leap_month > 0 && lunar_date[1] > lunar_leap_month
        lunar_festival = @@lunar_festival[format_date(lunar_date[1], lunar_date[2].to_i)]
      else
        lunar_festival = @@lunar_festival[format_date(lunar_date[1] - 1, lunar_date[2].to_i)]
      end

      lunar_festival
    end

    def solar_festival()
      @@solar_festival[format_date(@date.month - 1, @date.day)]
    end

  private

    def cyclical_year(y)
      num = y - 1900 + 36
      cyclicalm(num)
    end

    def cyclicalm(num)
      @@gan[num % 10] + @@zhi[num % 12]
    end

    # 传出y年m月d日对应的农历.
    # year0 .month1 .day2 .yearCyl3 .monCyl4 .dayCyl5 .isLeap6
    def convert(y, m, d)
      nongDate = []   
      i = 0
      temp = 0
      leap = 0
      baseDate = Date.new(0 + 1900, 1, 31)
         
      objDate = Date.new(y, m, d);
      offset = objDate - baseDate
      nongDate[5] = offset + 40;
      nongDate[4] = 14;

      i = 1900
      while (i < 2050 && offset > 0)
        temp = days_in_lunar_date(i)
        offset -= temp
        nongDate[4] += 12

        i += 1
      end

      if (offset < 0)
        offset += temp
        i -= 1
        nongDate[4] -= 12
      end

      nongDate[0] = i
      nongDate[3] = i - 1864
      leap = leap_month(i) #闰哪个月
      nongDate[6] = 0

      i = 1  
      while(i<13 && offset > 0)
        #闰月
        if (leap > 0 && i == (leap + 1) && nongDate[6] == 0)
          i -= 1
          nongDate[6] = 1
          temp = leap_days( nongDate[0])
        else  
          temp = monthDays( nongDate[0], i)
        end   

        #解除闰月   
        if (nongDate[6] == 1 && i == (leap + 1))
          nongDate[6] = 0  
        end   
          offset -= temp   
          if (nongDate[6] == 0)   
            nongDate[4] += 1  
        end   

        i += 1  
      end   
      
      if (offset == 0 && leap > 0 && i == leap + 1)
        if (nongDate[6] == 1)
          nongDate[6] = 0
        else  
          nongDate[6] = 1
          i -= 1  
          nongDate[4] -= 1  
        end
      end   
      
      if (offset < 0)
        offset += temp
        i -= 1
        nongDate[4] -= 1
      end
      
      nongDate[1] = i
      nongDate[2] = offset + 1
    
      nongDate
    end

    def get_day_in_chinese(day)
      a = ""  
      if (day == 10)
        return "初十"
      elsif (day == 20)
        return "二十"
      elsif (day == 30)
        return "三十"
      end
             
      two = ((day) / 10).to_i()

      if (two == 0)   
        a = "初"  
      elsif (two == 1)   
        a = "十"
      elsif (two == 2)   
        a = "廿"
      elsif (two == 3)   
        a = "三"
      else
        a = "ERROR"  
      end   
      
      one =  (day % 10)   
    
      case one   
        when 1 then a += "一"
        when 2 then a += "二"
        when 3 then a += "三"
        when 4 then a += "四"
        when 5 then a += "五"
        when 6 then a += "六"
        when 7 then a += "七"
        when 8 then a += "八"
        when 9 then a += "九"
      end
      
      return a 
    end

    # Return the days in lunar of y year.
    def days_in_lunar_date(y)
      sum = 348  
      i = 0x8000  
      while i > 0x8  
        if ((@@lunar_info[y - 1900] & i) != 0)   
          sum += 1  
        end   
        i >>= 1  
      end
    
      sum + leap_days(y)
    end   

    # Return the leap days in y year.
    def leap_days(y)
       if (leap_month(y) != 0)    
         if ((@@lunar_info[y - 1900] & 0x10000) != 0)   
           return 30  
         else  
           return 29  
         end   
       else  
         return 0  
       end
    end   

    #传回农历 y年闰哪个月 1-12 , 没闰传回 0  
    def leap_month(y)
      @@lunar_info[y - 1900] & 0xf
    end
    
    # Return the days of m month in y year.
    def  monthDays(y, m)
      if ((@@lunar_info[y - 1900] & (0x10000 >> m)) == 0)
        return 29
      else
        return 30
      end
    end

    def get_term(y, n)
      msecs = ( 31556925974.7*(y-1890) + @@term_info[n]*60000  ) + Time.utc(1890,1,5,16,2,31).to_i * 1000
      Time.at(msecs / 1000).utc.day
    end

    def format_date(month, day)
      month += 1
      month  = month < 10 ? '0' + month.to_s : month.to_s
      day    = day   < 10 ? '0' + day.to_s   : day.to_s

      'd' + month + day
    end

    def lunar_by_between(year, month, day)
      year_data = @@lunar_new_info[year - 1890]
      zen_month = year_data[1]
      zen_day   = year_data[2]
      between   = days_between_solar(year, zen_month, zen_day, year, month, day)
      if between == 0
        [year, 1, 1]
      else
        lunar_year = between > 0 ? year : year - 1;
        lunar_date_by_between(lunar_year, between)
      end
    end

    # 计算两个公历之间的天数
    def days_between_solar(by, bm, bd, ny, nm, nd)
      Date.new(ny, nm, nd) - Date.new(by, bm, bd)
    end

    # 通过间隔天数查询农历日期
    def lunar_date_by_between(year, between)
      lunar_year_days = days_in_lunar_year(year)
      end_day = between > 0 ? between : lunar_year_days[:year_days] - between.abs
      month_days = lunar_year_days[:month_days]
      temp_days = 0
      month = 0
      (0..month_days.size).each do |i|
        temp_days += month_days[i]
        if temp_days > end_day
          month = i
          temp_days = temp_days - month_days[i]
          break
        end
      end

      [year, month + 1, end_day - temp_days + 1]
    end

    def days_in_lunar_year(year)
      year_data   = @@lunar_new_info[year - 1890]
      leap_month  = year_data[0]
      month_data  = year_data[3].to_s(2)
      month_arr   = month_data.split('');
      # 还原数据至16位，少于16位的前面补0，二进制的前部0被忽略
      (0..(16 - month_arr.size - 1)).each do |i|
        month_arr = ['0'] +  month_arr
      end

      length      = leap_month ? 13 : 12
      year_days   = 0
      month_days  = []
      
      (0..(length - 1)).each do |i|
        if month_arr[i] == '0'
          year_days += 29;
          month_days.push(29)
        else
          year_days += 30
          month_days.push(30)
        end
      end

      {
        :year_days  => year_days,
        :month_days => month_days
      }
    end

    def lunar_leap_year(year)
      year_data = @@lunar_new_info[year - 1890]
      year_data[0]
    end

  end
end
