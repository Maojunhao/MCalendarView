//
//  NSDate+MCTransform.h
//  MCalendarView
//
//  Created by Maojunhao on 2020/4/28.
//  Copyright © 2020 Maojunhao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (MCTransform)

+ (NSDateFormatter *)setDateFormatter:(NSString *)formatter;

#pragma mark - NSDateComponents

+ (NSDateComponents *)components:(NSDate *)date;

+ (NSDateComponents *)componentsByChinese:(NSDate *)date;

#pragma mark - NSTimeInterval

+ (NSTimeInterval)dateStringToTimeInterval:(NSString *)dateString dateFormatter:(NSString *)formatter;

+ (NSTimeInterval)componentToTimeInterval:(NSDateComponents *)components dateFormatter:(NSString *)formatter;

+ (NSTimeInterval)dateToTimeInterval:(NSDate *)date dateFormatter:(NSString *)formatter;

#pragma mark - NSString / week

+ (NSString *)weekWithDate:(NSDate *)date;

+ (NSString *)weekWithDateComponents:(NSDateComponents *)components;

/**
 * 格式化时间格式 08-08 周五
 * @param timeInterval 时间戳
 */
+ (NSString *)monthWeekWithTimeInterval:(NSTimeInterval)timeInterval;

+ (NSString *)weekWithDateString:(NSString *)dateStr dateFormatter:(NSString *)formatterStr;

#pragma mark - NSString / time

+ (NSString *)dateToString:(NSDate *)date dateFormatter:(NSString *)formatter;

+ (NSString *)timeIntervalToString:(NSTimeInterval)timeInterval dateFormatter:(NSString *)formatter;

+ (NSString *)componentToDateString:(NSDateComponents *)components dateFormatter:(NSString *)formatter;

#pragma mark - NSString / transform

+ (NSString *)transformDateString:(NSString *)dateString fromFmt:(NSString *)formatter toFmt:(NSString *)toFormatter;

#pragma mark - NSDate

+ (NSDate *)componentToDate:(NSDateComponents *)components;

+ (NSDate *)dateWithDateString:(NSString *)timeString formatString:(NSString *)format;

+ (NSDate *)dateWithPresentDate:(NSDate*)presentDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

#pragma mark - 其他方法

// 获取两天中间间隔多少天
+ (NSInteger)daysBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

// 获取当前月有多少天
+ (NSInteger)totaldaysInMonth:(NSDate *)date;

// 是否和当前同一天
+ (BOOL)isCurrentDay:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
