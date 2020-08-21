//
//  NSDate+LYExtention.h
//  LYFramework
//
//  Created by anita on 2020/8/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
格式化参数如下：
G: 公元时代，例如AD公元
yy: 年的后2位
yyyy: 完整年
MM: 月，显示为1-12
MMM: 月，显示为英文月份简写,如 Jan
MMMM: 月，显示为英文月份全称，如 Janualy
dd: 日，2位数表示，如02
d: 日，1-2位显示，如 2
EEE: 简写星期几，如Sun
EEEE: 全写星期几，如Sunday
aa: 上下午，AM/PM
H: 时，24小时制，0-23
K：时，12小时制，0-11
m: 分，1-2位
mm: 分，2位
s: 秒，1-2位
ss: 秒，2位

S: 毫秒

常用日期结构：
yyyy-MM-dd HH:mm:ss.SSS
yyyy-MM-dd HH:mm:ss
yyyy-MM-dd
*/

//  常用日期结构:
/// 精确到天  eg. 2019-01-01
UIKIT_EXTERN NSString *const WDateTypeDay;
/// 精确到秒  eg. 2019-01-01 00:00:00
UIKIT_EXTERN NSString *const WDateTypeSeconds;
/// 精确到毫秒 eg. 2019-01-01 00:00:00 000
UIKIT_EXTERN NSString *const WDateTypeMillisecond;

@interface NSDate (LYExtention)

/**
 根据日期生成日期字符串
 
 @param date 日期
 @param format 生成的格式
 @return 日期字符串
 */
+(NSString *)stringWithDate:(NSDate *)date formatType:(NSString *)format;

/**
 根据日期字符串生成日期
 
 @param string 日期字符串
 @param format 日期字符串格式
 @return 日期
 */
+(NSDate *)dateWithString:(NSString *)string formatType:(NSString *)format;

/**
 获取日期对应的星期几

 @param date 日期
 @return 1:星期一 依次递加
 */
+(NSInteger)weekdayWithDate:(NSDate *)date;

/**
 对比两个日期早晚,返回两日期天数差值
 
 @param oldDate 老日期
 @param newDate 新日期
 @return 0：日期相同
        -1：oldDate比newDate晚一天
         2：newDate比oldDate晚两天
 */
+(NSInteger)compareDate:(NSDate *)oldDate toDate:(NSDate *)newDate;

/**
 时间友好显示格式化，规则如下：
 1.小于1分钟  “刚刚”
 2.小于1小时  “xx分钟前”
 3.当天内    “xx小时前”
 4.昨天      “昨天 xx:xx:xx”
 5.当年      “xx月xx日 xx:xx”
 6.其他      “xxxx年xx月xx日 xx:xx”
 
 @param date 时间
 @return 格式化后字符串
 */
+(NSString *)friendlyDisplayWithDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
