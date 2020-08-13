//
//  NSDate+MCTransform.m
//  MCalendarView
//
//  Created by Maojunhao on 2020/4/28.
//  Copyright © 2020 Maojunhao. All rights reserved.
//

#import "NSDate+MCTransform.h"

@implementation NSDate (MCTransform)

+ (NSDateFormatter *)setDateFormatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    return dateFormatter;
}

#pragma mark - NSDateComponents

+ (NSDateComponents *)components:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[self class] setDateFormatter:@"yyyy-MM-dd"];
    NSString *dateString = [NSDate timeIntervalToString:date.timeIntervalSince1970 dateFormatter:dateFormatter.dateFormat];
    NSDate *startDate = [dateFormatter dateFromString:dateString];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | kCFCalendarUnitWeekday | kCFCalendarUnitWeekdayOrdinal) fromDate:startDate];
    
    return components;
}

+ (NSDateComponents *)componentsByChinese:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[self class] setDateFormatter:@"yyyy-MM-dd"];
    NSString *dateString = [NSDate timeIntervalToString:date.timeIntervalSince1970 dateFormatter:dateFormatter.dateFormat];
    NSDate *startDate = [dateFormatter dateFromString:dateString];
    NSCalendar *chineseCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *components = [chineseCalendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | kCFCalendarUnitWeekday | kCFCalendarUnitWeekdayOrdinal) fromDate:startDate];
    
    return components;
}

#pragma mark - NSTimeInterval

+ (NSTimeInterval)dateStringToTimeInterval:(NSString *)dateString dateFormatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = nil;
    
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:formatter];
        [dateFormatter setLocale:[NSLocale currentLocale]];
    }
    
    NSDate *date = [dateFormatter dateFromString:dateString];
    NSTimeInterval interval = [date timeIntervalSince1970];
    
    return interval;
}

+ (NSTimeInterval)componentToTimeInterval:(NSDateComponents *)components dateFormatter:(NSString *)formatter {
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:components];
    return [[self class] dateToTimeInterval:date dateFormatter:formatter];
}

+ (NSTimeInterval)dateToTimeInterval:(NSDate *)date dateFormatter:(NSString *)formatter {
    NSString *dateString = [[self class] dateToString:date dateFormatter:formatter];
    NSTimeInterval timeInterval = [[self class] dateStringToTimeInterval:dateString dateFormatter:formatter];
    return timeInterval;
}

#pragma mark - NSString / week

+ (NSString *)weekWithDate:(NSDate *)date {
    NSDateComponents *components = [[self class] components:date];
    return [[self class] weekWithDateComponents:components];
}

+ (NSString *)monthWeekWithTimeInterval:(NSTimeInterval)timeInterval {
    NSString *month = [NSDate timeIntervalToString:timeInterval dateFormatter:@"MM-dd"];
    NSString *week = [NSDate weekWithDateString:[NSDate timeIntervalToString:timeInterval dateFormatter:@"yyyyMMdd"] dateFormatter:@"yyyyMMdd"];
    return [NSString stringWithFormat:@"%@ %@", month, week];
}

+ (NSString *)weekWithDateString:(NSString *)dateStr dateFormatter:(NSString *)formatterStr {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    NSDate *date = [formatter dateFromString:dateStr];
    return [[self class] weekWithDate:date];
}

+ (NSString *)weekWithDateComponents:(NSDateComponents *)components {
    NSInteger weekday = [components weekday];
    
    NSString *week = @"";
    if (weekday == 1) {
        week = @"周日";
    } else if (weekday == 2) {
        week = @"周一";
    } else if (weekday == 3) {
        week = @"周二";
    } else if (weekday == 4) {
        week = @"周三";
    } else if (weekday == 5) {
        week = @"周四";
    } else if (weekday == 6) {
        week = @"周五";
    } else if (weekday == 7) {
        week = @"周六";
    }
    return week;
}

#pragma mark - NSString / time

+ (NSString *)dateToString:(NSDate *)date dateFormatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[self class] setDateFormatter:formatter];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+ (NSString *)timeIntervalToString:(NSTimeInterval)timeInterval dateFormatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[self class] setDateFormatter:formatter];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+ (NSString *)componentToDateString:(NSDateComponents *)components dateFormatter:(NSString *)formatter {
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:components];
    return [[self class] dateToString:date dateFormatter:formatter];
}

#pragma mark - NSString / transform

+ (NSString *)transformDateString:(NSString *)dateString fromFmt:(NSString *)formatter toFmt:(NSString *)toFormatter {
    NSDate *date = [[self class] dateWithDateString:dateString formatString:formatter];
    return [[self class] dateToString:date dateFormatter:toFormatter];
}

#pragma mark - NSDate

+ (NSDate *)componentToDate:(NSDateComponents *)components {
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:components];
    return date;
}

+ (NSDate *)dateWithDateString:(NSString *)dateString formatString:(NSString *)format {
    NSDateFormatter *dateFormatter = [[self class] setDateFormatter:format];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

+ (NSDate *)dateWithPresentDate:(NSDate*)presentDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    NSDateComponents *adcomps = [[NSDateComponents alloc] init];

    [adcomps setYear:year];

    [adcomps setMonth:month];

    [adcomps setDay:day];

    return [calendar dateByAddingComponents:adcomps toDate:presentDate options:0];
}

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];

    [adcomps setYear:year];

    [adcomps setMonth:month];

    [adcomps setDay:day];
    
    return [calendar dateFromComponents:adcomps];
}

#pragma mark - 其他方法

// 获取两天中间间隔多少天
+ (NSInteger)daysBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSDateComponents *startComponents = [NSDate components:startDate];
    NSDateComponents *endComponents = [NSDate components:endDate];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDateComponents:startComponents toDateComponents:endComponents options:nil];
    
    return components.day;
}

// 获取当前月共有多少天
+ (NSInteger)totaldaysInMonth:(NSDate *)date {
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    return daysInLastMonth.length;
}

// 日期判断

+ (BOOL)isCurrentDay:(NSDate *)date {
    BOOL result = NO;
    
    NSString *dateString = [NSDate dateToString:date dateFormatter:@"yyyy-MM-dd"];
    NSString *nowString = [NSDate dateToString:[NSDate date] dateFormatter:@"yyyy-MM-dd"];
    
    if ([dateString isEqualToString:nowString]) {
        result = YES;
    }
    
    return result;
}


@end
