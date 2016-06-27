//
//  NSDate+XQDate.h
//  AFtest
//
//  Created by Xia_Q on 15/11/17.
//  Copyright (c) 2015年 XiaQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XQDate)

+ (NSString *)dateStringWithDate:(NSDate *)date;

+ (NSString *)timeStringWithDate:(NSDate *)date;

+ (NSDateFormatter *)formatterWithFormat:(NSString *)format;

+(NSString *)backStrWith:(NSString *)timeChat;

//获取当地时间
+(NSDate *)getLocalDate;

/*
 获取与现在相隔x天的时间，x为负数，即表示过去；为正数即表示将来
 */
+(NSDate *)spaceTimeToNowWithDay:(int)x;

//计算上报时间差
+(NSString *)backSpaceStringWithTimeStr:(NSString *)timeStr;

+(int)backIntDayWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
/*
 startDate:开始的时间
 x:相隔多少天
 y:相隔多少小时
 z:相隔多少秒
 */
+(NSDate *)spaceTimeToDate:(NSDate *)startDate WithDay:(int)x Hour:(int)y Minute:(int)z;

+(NSDate *)spaceTimeToDate:(NSDate *)startDate WithYear:(int)q Day:(int)x Hour:(int)y Minute:(int)z;

/*
 将时间装化为字符串格式
 */
+(NSString *)getStringFromeDate:(NSDate *)date;

+(NSString *)getStringFromeDate:(NSDate *)date withFormatStr:(NSString *)FormatStr;

/*
 将字符串转化为时间格式
 */
+(NSDate *)getDateFromTimeStr:(NSString *)timeStr;

+(NSDate *)getDateFromTimeStr:(NSString *)timeStr withFormatStr:(NSString *)FormatStr;

@end
