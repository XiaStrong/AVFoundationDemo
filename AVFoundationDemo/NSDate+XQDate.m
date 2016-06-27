//
//  NSDate+XQDate.m
//  AFtest
//
//  Created by Xia_Q on 15/11/17.
//  Copyright (c) 2015年 XiaQiang. All rights reserved.
//

#import "NSDate+XQDate.h"

@implementation NSDate (XQDate)

+ (NSString *)dateStringWithDate:(NSDate *)date {
    NSDateFormatter *formatter = [self formatterWithFormat:@"MMddyyyyHHmmss"];
    return [formatter stringFromDate:date];
}

+ (NSString *)timeStringWithDate:(NSDate *)date {
    NSDateFormatter *formatter = [self formatterWithFormat:@"HHmmss"];
    return [formatter stringFromDate:date];
}

+ (NSDateFormatter *)formatterWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    NSString *formatStr = [NSDateFormatter dateFormatFromTemplate:format options:0 locale:[NSLocale currentLocale]];
    [formatter setDateFormat:formatStr];
    return formatter;
}

+(NSString *)backStrWith:(NSString *)timeChat{
    
    double babytimestampval =  [timeChat doubleValue]/1000;
    NSTimeInterval babytimestamp = (NSTimeInterval)babytimestampval;
    NSDate *babyupdatetimestamp = [NSDate dateWithTimeIntervalSince1970:babytimestamp];
    NSString *pushtime=[NSDate getStringFromeDate:babyupdatetimestamp];
    return pushtime;
}


+(NSDate *)getLocalDate
{
    NSDate *date =[NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}

+(int)backIntDayWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    NSCalendar *mycalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlag = NSDayCalendarUnit;
    NSDateComponents *components = [mycalendar components:unitFlag fromDate:fromDate toDate:toDate options:0];
    int days = (int)[components day];
    return days;
}

+(NSString *)backSpaceStringWithTimeStr:(NSString *)timeStr
{
    //计算上报时间差
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
//    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];
    //设置一个字符串的时间
    NSMutableString *datestring = [NSMutableString stringWithFormat:@"%@",timeStr];
    //注意 如果20141202052740必须是数字，如果是UNIX时间，不需要下面的插入字符串。
    [datestring insertString:@"-" atIndex:4];
    [datestring insertString:@"-" atIndex:7];
    [datestring insertString:@" " atIndex:10];
    [datestring insertString:@":" atIndex:13];
    [datestring insertString:@":" atIndex:16];

    NSDateFormatter * dm = [[NSDateFormatter alloc]init];
    //指定输出的格式   这里格式必须是和上面定义字符串的格式相同，否则输出空
    [dm setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate * newdate = [dm dateFromString:datestring];
    long dd = (long)[datenow timeIntervalSince1970] - [newdate timeIntervalSince1970];
    NSString *timeString=@"";
    if (dd/3600<1)
    {
        timeString = [NSString stringWithFormat:@"%ld", dd/60];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }
    if (dd/3600>1&&dd/86400<1)
    {
        timeString = [NSString stringWithFormat:@"%ld", dd/3600];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    if (dd/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%ld", dd/86400];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    }
    NSLog(@"=====%@",timeString);
    return timeString;
}

+(NSDate *)spaceTimeToNowWithDay:(int)x
{
    NSDate *now =[NSDate date];
    NSDate *date=[now dateByAddingTimeInterval:60*60*24*x];
    return date;
}

+(NSDate *)spaceTimeToDate:(NSDate *)startDate WithYear:(int)q Day:(int)x Hour:(int)y Minute:(int)z
{
    NSDateComponents *compt=[[NSDateComponents alloc]init];
    [compt setYear:q];
    [compt setDay:x];
    [compt setHour:y];
    [compt setMinute:z];
    NSCalendar *calendar=[NSCalendar currentCalendar];
    
    NSDate *date=[calendar dateByAddingComponents:compt toDate:startDate options:0];
    return date;

}


+(NSDate *)spaceTimeToDate:(NSDate *)startDate WithDay:(int)x Hour:(int)y Minute:(int)z
{
    NSDateComponents *compt=[[NSDateComponents alloc]init];
    [compt setDay:x];
    [compt setHour:y];
    [compt setMinute:z];
    NSCalendar *calendar=[NSCalendar currentCalendar];

    NSDate *date=[calendar dateByAddingComponents:compt toDate:startDate options:0];
    return date;
}

+(NSString *)getStringFromeDate:(NSDate *)date
{
    NSDateFormatter *dateFor = [[NSDateFormatter alloc] init];
    dateFor.dateFormat = @"yyyy-MM-dd";
    NSString *string=[dateFor stringFromDate:date];
    return string;
}


+(NSString *)getStringFromeDate:(NSDate *)date withFormatStr:(NSString *)FormatStr
{
    //1.将时间转化为字符串需要一个时间格式器
    NSDateFormatter *dateFor = [[NSDateFormatter alloc] init];
    
    //hh 代表12进制
    //HH 代表24进制
//    dateFor.dateFormat = @"yyyy年MM月dd日 HH:mm:ss";
    
    dateFor.dateFormat=FormatStr;
    NSString *string=[dateFor stringFromDate:date];
    return string;
}


+(NSDate *)getDateFromTimeStr:(NSString *)timeStr
{
    NSDateFormatter *dateFor = [[NSDateFormatter alloc] init];
    dateFor.dateFormat = @"yyyy-MM-dd";
    NSDate *date=[dateFor dateFromString:timeStr];
    return date;

}

+(NSDate *)getDateFromTimeStr:(NSString *)timeStr withFormatStr:(NSString *)FormatStr
{
    NSDateFormatter *dateFor = [[NSDateFormatter alloc] init];
    dateFor.dateFormat=FormatStr;
    NSDate *date=[dateFor dateFromString:timeStr];
    return date;
}

@end
