package com.deelon.crowdfunding.common.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 * Created by jiang on 15/5/26.
 */
public class DateUtilWuyouchou {


    /**
     * 在给定日期上加上指定的天数
     * @param originalDay 给定的日期
     * @param days 偏移的天数
     * @return
     */
    public static Date addDays(Date originalDay, int days){
        Calendar cal1 = new GregorianCalendar();
        cal1.setTime(originalDay);
        cal1.add(Calendar.DATE, days);

        return cal1.getTime();
    }

    /**
     *格式化日期
     *
     * @param date
     * @param pattern
     * @return
     */
    public static String formatDate(Date date,String pattern){
        SimpleDateFormat sdf=new SimpleDateFormat(pattern);

        return sdf.format(date);
    }



}
