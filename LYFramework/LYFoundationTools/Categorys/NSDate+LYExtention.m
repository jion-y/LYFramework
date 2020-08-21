//
//  NSDate+LYExtention.m
//  LYFramework
//
//  Created by anita on 2020/8/21.
//

#import "NSDate+LYExtention.h"
NSString *const WDateTypeDay = @"yyyy-MM-dd";
NSString *const WDateTypeSeconds = @"yyyy-MM-dd HH:mm:ss";
NSString *const WDateTypeMillisecond = @"yyyy-MM-dd HH:mm:ss.SSS";

@implementation NSDate (LYExtention)

+ (NSDateFormatter *)dateFormatter
{
    NSDateFormatter *df = [NSDateFormatter new];
    //设置地区为当前地区
    [df setLocale:[NSLocale currentLocale]];
    //获取当前时区
    NSTimeZone *toTimeZone = [NSTimeZone localTimeZone];
    //获取当前时区的时间与GMT0时区相差的毫秒数
    NSInteger toGMTOffset = [toTimeZone secondsFromGMTForDate:[NSDate date]];
    //设置时区 (注: 要用相差的时间来设置, 不能直接设置上海或北京时区, 虽然都是+8时区; 不然会有夏令时的问题,
    //如1989-04-16转换会失败为nil, 因为这一天没有0时到1时)
    [df setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:toGMTOffset]];
    return df;
}

+ (NSString *)stringWithDate:(NSDate *)date formatType:(NSString *)format
{
    NSDateFormatter *df = [self dateFormatter];
    [df setDateFormat:format];
    return [df stringFromDate:date];
}

+ (NSDate *)dateWithString:(NSString *)string formatType:(NSString *)format
{
    NSDateFormatter *df = [self dateFormatter];
    [df setDateFormat:format];
    return [df dateFromString:string];
}

+ (NSInteger)weekdayWithDate:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *cms = [gregorian components:NSCalendarUnitWeekday fromDate:date];
    //    1 是星期日 往后递加
    NSInteger _weekday = [cms weekday];
    return (_weekday == 1) ? 7 : _weekday - 1;
}

+ (NSInteger)compareDate:(NSDate *)oldDate toDate:(NSDate *)newDate
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *cms =
        [gregorian components:NSCalendarUnitDay fromDate:oldDate toDate:newDate options:NSCalendarWrapComponents];
    return cms.day;
}

+ (NSString *)friendlyDisplayWithDate:(NSDate *)date
{
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval inputTime = [date timeIntervalSince1970];

    NSTimeInterval time = currentTime - inputTime;
    int sec = time / 60;
    if (sec == 0)
    {
        return @"刚刚";
    }

    if (sec < 60)
    {
        return [NSString stringWithFormat:@"%d分钟前", sec];
    }
    // 获取用户的当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 如果给定日期是今天
    if ([calendar isDateInToday:date])
    {
        int hours = time / 3600;
        return [NSString stringWithFormat:@"%d小时前", hours];
    }
    // 如果给定日期是昨天
    if ([calendar isDateInYesterday:date])
    {
        return [self stringWithDate:date formatType:@"昨天 HH:mm:ss"];
    }
    // 如果给定日期跟当前日期是同一年
    NSInteger fromYear = [calendar component:NSCalendarUnitYear fromDate:date];
    NSInteger toYear = [calendar component:NSCalendarUnitYear fromDate:NSDate.date];
    if (fromYear - toYear == 0) {
        return [self stringWithDate:date formatType:@"MM月dd日 HH:mm:ss"];
    }
    return [self stringWithDate:date formatType:@"yyyy年MM月dd日 HH:mm:ss"];
}
@end
