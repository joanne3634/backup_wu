package com.deelon.crowdfunding.common.util;

import java.util.Calendar;
import java.util.Date;

/**
 * Created by Iccy on 15/5/20.
 */
public class DealTimeUtil {
    /**
     * 计算两个日期之间相差的天数
     * @param date1
     * @param date2
     * @return
     */
    public static int daysBetween(Date date1,Date date2)
    {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date1);
        long time1 = cal.getTimeInMillis();
        cal.setTime(date2);
        long time2 = cal.getTimeInMillis();
        long between_days=(time1-time2)/(1000*3600*24);

        return Integer.parseInt(String.valueOf(between_days));
    }
}
