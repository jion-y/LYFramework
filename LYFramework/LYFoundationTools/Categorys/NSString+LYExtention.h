//
//  NSString+LYExtention.h
//  LYFramework
//
//  Created by anita on 2020/8/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LYExtention)

/// 验证手机号码是否合法
/// @param phoneNumber 手机号码
+ (BOOL)checkPhoneNumber:(NSString *)phoneNumber;

/**
 *  检查邮箱地址格式
 *
 *  @param EmailAddress 邮箱地址
 */
+ (BOOL)checkEmailAddress:(NSString *)EmailAddress;

/**
 *  判断身份证是否合法
 *
 *  @param number 身份证号码
 */
+ (BOOL)checkIdentityNumber:(NSString *)number;

/**
 *  从身份证里面获取性别man 或者 woman 不正确的身份证返回nil
 *
 *  @param number 身份证
 */
+ (NSString *)getGenderFromIdentityNumber:(NSString *)number;

/**
 *  从身份证获取生日,身份证格式不正确返回nil,正确返回:1990年01月01日
 *
 *  @param number 身份证
 */
+ (NSString *)getBirthdayFromIdentityNumber:(NSString *)number;
//过滤特殊字符串
+ (NSString *)filterSpecialString:(NSString *)string;
// 判断字符串为空
+ (BOOL)isEmptyOrNull:(NSString *)string;

// 检查字符串是否是纯数字
+ (BOOL)checkStringIsOnlyDigital:(NSString *)str;

//检查字符串是否为nil 转为@""
+ (NSString *)checkStringValue:(id)str;
//判断字符串中包含汉字
+ (BOOL)checkStringIsContainerChineseCharacter:(NSString *)string;
/**
 *  计算字符串尺寸
 *  @param string 字符串
 *  @param font   字体
 *  @param size 大小
 */
+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font size:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
