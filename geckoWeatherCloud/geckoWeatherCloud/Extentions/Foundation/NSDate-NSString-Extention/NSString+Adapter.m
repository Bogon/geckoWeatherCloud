//
//  NSString+Adapter.m
//  weather
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 hellogeek.com. All rights reserved.
//

#import "NSString+Adapter.h"

static NSCalendar* g_UMCalendar = nil;
static NSCalendar* g_UMCurrentCalendar = nil;
NSString* const g_UMNullDateFormat = @"";
NSString* const g_UMFullDateFormat = @"yyyy-MM-dd HH:mm:ss";
NSString* const g_UMTodayDateFormat = @"HH:mm";
NSString* const g_UMCurYearDateFormat = @"MM-dd";
NSString* const g_UMBeforeCurYearDateFormat = @"yy-MM-dd";
NSString* const g_UMAfterCurYearDateFormat = @"yy-MM-dd";
NSString* const g_UMYesteday = @"昨天";

@implementation NSString (Adapter)

//判断内容是否全部为空格  yes 全部为空格  no 不是
- (BOOL) isEmpty{
    if (!self) {
        return YES;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return YES;
        } else {
            return NO;
        }
    }
}
//截取两个字符串中间的内容
- (NSArray *)componentsSeparatedFromString:(NSString *)fromString toString:(NSString *)toString
{
    if (!fromString || !toString || fromString.length == 0 || toString.length == 0) {
        return nil;
    }
    NSMutableArray *subStringsArray = [[NSMutableArray alloc] init];
    NSString *tempString = self;
    NSRange range = [tempString rangeOfString:fromString];
    while (range.location != NSNotFound) {
        tempString = [tempString substringFromIndex:(range.location + range.length)];
        range = [tempString rangeOfString:toString];
        if (range.location != NSNotFound) {
            [subStringsArray addObject:[tempString substringToIndex:range.location]];
            range = [tempString rangeOfString:fromString];
        }
        else
        {
            break;
        }
    }
    return subStringsArray;
}

/**
 手机号码 13[0-9],14[5|7|9],15[0-3],15[5-9],17[0|1|3|5|6|8],18[0-9]
 移动：134[0-8],13[5-9],147,15[0-2],15[7-9],178,18[2-4],18[7-8]
 联通：13[0-2],145,15[5-6],17[5-6],18[5-6]
 电信：133,1349,149,153,173,177,180,181,189
 虚拟运营商: 170[0-2]电信  170[3|5|6]移动 170[4|7|8|9],171 联通
 上网卡又称数据卡，14号段为上网卡专属号段，中国联通上网卡号段为145，中国移动上网卡号段为147，中国电信上网卡号段为149
 */
- (BOOL)valiMobile
{
    NSString * MOBIL = @"^1(3[0-9]|4[5679]|5[0-35-9]|6[6]|7[01356]|8[0-9]|9[89])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    if ([regextestmobile evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}

-(BOOL)checkIsPeopleNumber
{
    NSString *num = self;
    //长度不为18的都排除掉
    if (num.length!=18) {
        return NO;
    }
    
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:num];
    
    if (!flag) {
        return flag;    //格式错误
    }else {
        //格式正确在判断是否合法
        
        //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++)
        {
            NSInteger subStrIndex = [[num substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            
            idCardWiSum+= subStrIndex * idCardWiIndex;
            
        }
        
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        
        //得到最后一位身份证号码
        NSString * idCardLast= [num substringWithRange:NSMakeRange(17, 1)];
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2)
        {
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
            {
                return YES;
            }else
            {
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
    }
}

- (NSString *)timeToyyyy_MM_dd{
    // 时间字符串
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init]; // 2.格式化对象的样式/z大小写都行/格式必须严格和字符串时间一样
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mmZ"; // 3.利用时间格式化对象让字符串转换成时间 (自动转换0时区/东加西减)
    NSDate *date = [formatter dateFromString:self];
    
    NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init];
    formatter1.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter1 setDateStyle:NSDateFormatterMediumStyle];
    [formatter1 setTimeStyle:NSDateFormatterShortStyle];
    [formatter1 setDateFormat:@"yyyy-MM-dd"];
    NSString* dateString = [formatter1 stringFromDate:date];
    return dateString;
}

//格林威志转 yyyy-MM-dd HH:mm
- (NSString *)timeToyyyy_MM_ddHHMMString {
    // 时间字符串
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init]; // 2.格式化对象的样式/z大小写都行/格式必须严格和字符串时间一样
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mmZ"; // 3.利用时间格式化对象让字符串转换成时间 (自动转换0时区/东加西减)
    NSDate *date = [formatter dateFromString:self];
    
    NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init];
    formatter1.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter1 setDateStyle:NSDateFormatterMediumStyle];
    [formatter1 setTimeStyle:NSDateFormatterShortStyle];
    [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString* dateString = [formatter1 stringFromDate:date];
    return dateString;
}

- (NSString *)timeToyyyyMMdd{
    // 时间字符串
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init]; // 2.格式化对象的样式/z大小写都行/格式必须严格和字符串时间一样
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ"; // 3.利用时间格式化对象让字符串转换成时间 (自动转换0时区/东加西减)
    NSDate *date = [formatter dateFromString:self];
    
    NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init];
    formatter1.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter1 setDateStyle:NSDateFormatterMediumStyle];
    [formatter1 setTimeStyle:NSDateFormatterShortStyle];
    [formatter1 setDateFormat:@"yyyy年MM月dd日"];
    NSString* dateString = [formatter1 stringFromDate:date];
    return dateString;
}


- (NSString *)timeToyyyyMMddHHmmssString{
    // 时间字符串
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init]; // 2.格式化对象的样式/z大小写都行/格式必须严格和字符串时间一样
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ"; // 3.利用时间格式化对象让字符串转换成时间 (自动转换0时区/东加西减)
    NSDate *date = [formatter dateFromString:self];
    
    NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init];
    formatter1.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter1 setDateStyle:NSDateFormatterMediumStyle];
    [formatter1 setTimeStyle:NSDateFormatterShortStyle];
    [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* dateString = [formatter1 stringFromDate:date];
    return dateString;
}

- (NSString *)timeToGreenDLXTime{
    // 时间字符串
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init]; // 2.格式化对象的样式/z大小写都行/格式必须严格和字符串时间一样
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss"; // 3.利用时间格式化对象让字符串转换成时间 (自动转换0时区/东加西减)
    NSDate *date = [formatter dateFromString:self];
    
    NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init];
    formatter1.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter1 setDateStyle:NSDateFormatterMediumStyle];
    [formatter1 setTimeStyle:NSDateFormatterShortStyle];
    [formatter1 setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSString* dateString = [formatter1 stringFromDate:date];
    return dateString;
}

- (NSTimeInterval)timeToGreenDLXToTimeString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSDate *Date = [formatter dateFromString:self];
    NSTimeInterval timeStr = [Date timeIntervalSince1970];
    return timeStr;
}

- (NSString *)timeStringToGreenDLX{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self longLongValue]/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

- (NSString *)timeApendWithYear:(NSInteger )year Month:(NSInteger)month Day:(NSInteger)day {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter  setDateFormat:@"yyyy-MM-dd"];
    NSDate* date = [dateFormatter dateFromString:self];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:year];
    [comps setMonth:month];
    [comps setDay:day];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *myDate = [calendar dateByAddingComponents:comps toDate:date options:0];
    
    NSString *time = [dateFormatter stringFromDate:myDate];
    return time;
}

+ (BOOL) isEmpty {
    NSString *str = [self string];
    if(!str) {
        return true;
    }else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if([trimedString length] == 0) {
            return true;
        }else {
            return false;
        }
    }
}

- (NSString *)createCommentTimeString
{
    if (![self isKindOfClass:[NSString class]] || self.length == 0) {
        return g_UMNullDateFormat;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (!g_UMCalendar) {
        g_UMCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    [dateFormatter setCalendar:g_UMCalendar];
    [dateFormatter setDateFormat:g_UMFullDateFormat];
    NSDate *createDate= [dateFormatter dateFromString:self];
    if (createDate == nil) {
        return g_UMNullDateFormat;
    }
    
    if (!g_UMCurrentCalendar) {
        g_UMCurrentCalendar = [NSCalendar currentCalendar];
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        if (zone) {
            g_UMCurrentCalendar.timeZone = zone;
        }
    }
    
    //当前的时间
    NSDate *today = [NSDate date];
    
    NSDateComponents *todayComponents = [g_UMCurrentCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:today];
    
    NSDateComponents *createComponents = [g_UMCurrentCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:createDate];
    if (!todayComponents || !createComponents) {
        return g_UMNullDateFormat;
    }
    
    //计算创建时间的段一个月的最大天数
    NSRange createDateMaxDaysInCurMonth = [g_UMCurrentCalendar rangeOfUnit:NSCalendarUnitDay
                                                                    inUnit:NSCalendarUnitMonth
                                                                   forDate:createDate];
    if (createDateMaxDaysInCurMonth.length == NSNotFound) {
        //如果计算不出来当前的最大值，说明字符串给出的时间格式或者日期有问题
        return g_UMNullDateFormat;
    }
    
    
    NSString* reslutString = g_UMNullDateFormat;
    NSInteger yearsOffsetSinceNow =  createComponents.year - todayComponents.year;
    if (yearsOffsetSinceNow > 0) {
        //创建时间大于当前的时间，此处就直接显示日期(yy-MM-dd)
        [dateFormatter setDateFormat:g_UMAfterCurYearDateFormat];
        reslutString = [dateFormatter stringFromDate:createDate];
    }
    else if (yearsOffsetSinceNow == 0)
    {
        //在当年
        NSInteger monthOffsetSinceNow = createComponents.month - todayComponents.month;
        if (monthOffsetSinceNow > 0) {
            //创建时间大于当前的时间，此处就直接显示日期(yy-MM-dd)
            [dateFormatter setDateFormat:g_UMAfterCurYearDateFormat];
            reslutString = [dateFormatter stringFromDate:createDate];
        }
        else if (monthOffsetSinceNow == 0)
        {
            //在当月
            NSInteger dayOffsetSinceNow = createComponents.day - todayComponents.day;
            if (dayOffsetSinceNow > 0) {
                //创建时间大于当前的时间，此处就直接显示日期(yy-MM-dd)
                [dateFormatter setDateFormat:g_UMAfterCurYearDateFormat];
                reslutString = [dateFormatter stringFromDate:createDate];
            }
            else if (dayOffsetSinceNow == 0)
            {
                //今天（HH:mm）
                [dateFormatter setDateFormat:g_UMTodayDateFormat];
                reslutString = [dateFormatter stringFromDate:createDate];
            }
            else if (dayOffsetSinceNow == -1)
            {
                //昨天（昨天 HH:mm）
                [dateFormatter setDateFormat:g_UMTodayDateFormat];
                NSString* tempString = [dateFormatter stringFromDate:createDate];
                if (!tempString) {
                    return reslutString;
                }
                
                //2.5版的时间函数显示（昨天 HH:mm）
                reslutString = [NSString stringWithFormat:@"昨天%@",tempString];
                
                //2.6版本的时间函数显示 （昨天）
                //                reslutString = g_UMYesteday;
            }
            else
            {
                //今年（MM-dd）
                [dateFormatter setDateFormat:g_UMCurYearDateFormat];
                reslutString = [dateFormatter stringFromDate:createDate];
            }
        }
        else
        {
            if ((monthOffsetSinceNow == -1) &&
                (createDateMaxDaysInCurMonth.length == createComponents.day) && todayComponents.day == 1) {
                
                //昨天（昨天 HH:mm）
                [dateFormatter setDateFormat:g_UMTodayDateFormat];
                NSString* tempString = [dateFormatter stringFromDate:createDate];
                if (!tempString) {
                    return reslutString;
                }
                //2.5版的时间函数显示（昨天 HH:mm）
                reslutString = [NSString stringWithFormat:@"昨天%@",tempString];
                
                //2.6版本的时间函数显示 （昨天）
                //                reslutString = g_UMYesteday;
            }
            else
            {
                //今年（MM-dd）
                [dateFormatter setDateFormat:g_UMCurYearDateFormat];
                reslutString = [dateFormatter stringFromDate:createDate];
            }
        }
    }
    else
    {
        //在去年或者以前的某一天
        if ((yearsOffsetSinceNow == -1) &&
            (createComponents.day == createDateMaxDaysInCurMonth.length) &&
            (createComponents.month == 12)&&(todayComponents.month == 1) && (todayComponents.day == 1))
        {
            //昨天（昨天 HH:mm）
            [dateFormatter setDateFormat:g_UMTodayDateFormat];
            NSString* tempString = [dateFormatter stringFromDate:createDate];
            if (!tempString) {
                return reslutString;
            }
            
            //时间函数显示（昨天 HH:mm）
            reslutString = [NSString stringWithFormat:@"昨天%@",tempString];
        }
        else
        {
            //往年(yy-MM-dd)
            [dateFormatter setDateFormat:g_UMBeforeCurYearDateFormat];
            reslutString = [dateFormatter stringFromDate:createDate];
        }
    }
    
    return reslutString;
}



@end
