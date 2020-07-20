//
//  NSString+Adapter.h
//  weather
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 hellogeek.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Adapter)

- (BOOL) isEmpty;
//截取两个字符串中间的内容
- (NSArray *)componentsSeparatedFromString:(NSString *)fromString toString:(NSString *)toString;
//手机号验证
- (BOOL)valiMobile;
//身份证号验证
-(BOOL)checkIsPeopleNumber;
//格林威志转 yyyy年MM月dd日
- (NSString *)timeToyyyyMMdd;
//格林威志转 yyyy-MM-dd
- (NSString *)timeToyyyy_MM_dd;
//格林威志转 yyyy-MM-dd HH:mm
- (NSString *)timeToyyyy_MM_ddHHMMString;
//格林威志转 yyyy-MM-dd HH:mm:ss
- (NSString *)timeToyyyyMMddHHmmssString;
//yyyy-MM-dd HH:mm:ss转格林威志
- (NSString *)timeToGreenDLXTime;
//格林威志转时间戳
- (NSTimeInterval)timeToGreenDLXToTimeString;
//时间戳转格林威志时间
- (NSString *)timeStringToGreenDLX;
//yyyy-MM-dd增加N年N月N天
- (NSString *)timeApendWithYear:(NSInteger )year Month:(NSInteger)month Day:(NSInteger)day;
//yyyy-MM-dd HH:mm:ss转今天、昨天、几天前、日期
- (NSString *)createCommentTimeString;

@end

NS_ASSUME_NONNULL_END
