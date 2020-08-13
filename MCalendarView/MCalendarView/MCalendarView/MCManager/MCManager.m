//
//  MCManager.m
//  MCalendarView
//
//  Created by Maojunhao on 2020/4/21.
//  Copyright © 2020 Maojunhao. All rights reserved.
//

#import "MCManager.h"
#import "MCDataModel.h"
#import "NSDate+MCTransform.h"


@interface MCManager ()

@property (nonatomic, strong) NSMutableArray * datas;

@property (nonatomic, strong) NSMutableArray * noEmptyDatas;

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, strong) NSDate * todayDate;

@end

@implementation MCManager

static MCManager *manager = nil;
+ (instancetype)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MCManager alloc] init];
    });
    return manager;
}

- (NSArray *)initializeNonEmptyDatas:(NSArray *)datas
{
    if (datas == self.datas) {
        return self.noEmptyDatas;
    }
    
    NSMutableArray * nonEmptyDatas = [[NSMutableArray alloc] init];
    NSMutableDictionary * nonEmptyMap = [[NSMutableDictionary alloc] init];
    
    [self handleNonEmptyDatas:nonEmptyDatas nonEmptyMap:nonEmptyMap datas:self.datas];
    self.noEmptyMap = nonEmptyMap;
    self.noEmptyDatas = nonEmptyDatas;
    return nonEmptyDatas;
}

- (NSArray *)initializeDatasWithStartDate:(NSDate *)startDate maxMonth:(NSInteger)maxMonths
{
    if ([NSDate isCurrentDay:startDate] && self.datas) {
        return self.datas;
    }
    
    NSMutableArray *datas = [[NSMutableArray alloc] init];
    NSMutableDictionary *map = [[NSMutableDictionary alloc] init];
    NSDate *endDate = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitYear value:1 toDate:[NSDate date] options:NSCalendarWrapComponents];
    
    [self handleDatas:datas map:map startDate:startDate maxMonth:maxMonths invalidStartDate:[NSDate date] invalidEndDate:endDate];
        
    self.datas = datas;
    self.map = map;
    
    return datas;
}


#pragma mark - 基础数据函数

/**
    将 datas , map 按照 startDate , maxMonths 装填数据
 **/

- (void)handleDatas:(NSMutableArray *)datas map:(NSMutableDictionary *)map startDate:(NSDate *)startDate maxMonth:(NSInteger)maxMonths invalidStartDate:(NSDate *)invalidStartDate invalidEndDate:(NSDate *)invalidEndDate
{
    NSDate * firstDayOfStartDate = nil;
    BOOL OK = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&firstDayOfStartDate interval:nil forDate:startDate];
    
    NSAssert(OK, @"获取当月第一天失败");
    
    for (int section = 0; section < maxMonths; section++)
    {
        // 添加月数据源
        MCMonthModel *month = [[MCMonthModel alloc] init];
        NSMutableArray *days = [NSMutableArray array];
        [datas addObject:month];
        
        // 获取每月第一天日期
        NSDate *firstDate = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitMonth value:section toDate:firstDayOfStartDate options:NSCalendarWrapComponents];
        month.components = [NSDate components:firstDate];
        month.chineseComponents = [NSDate componentsByChinese:firstDate];
        
        [self handleDays:days map:map withMonth:month maxMonth:maxMonths firstDate:firstDate section:section invalidStartDate:invalidStartDate invalidEndDate:invalidEndDate];
        
        // 将统计好的日数据源赋值给MonthDO
        month.days = days;
    }
}

- (void)handleDays:(NSMutableArray *)days map:(NSMutableDictionary *)map withMonth:(MCMonthModel *)month maxMonth:(NSInteger)maxMonths firstDate:(NSDate *)firstDate section:(NSUInteger)section invalidStartDate:(NSDate *)invalidStartDate invalidEndDate:(NSDate *)invalidEndDate
{
    // 获取每月天数
    NSInteger daysCount = [NSDate totaldaysInMonth:firstDate];
    // 每月日历显示行数
    NSInteger maxRows = (daysCount + month.components.weekday - 1) % 7 > 0 ? (daysCount + month.components.weekday - 1) / 7 + 1 : (daysCount + month.components.weekday - 1) / 7;
    
    for (int row = 0; row < maxRows * 7; row++)
    {
        //添加日数据源
        MCDayModel *day = [[MCDayModel alloc] init];
        [days addObject:day];
        
        day.state = MCDayStateEmpty;
        
        if (row >= month.components.weekday - 1 && row < daysCount + month.components.weekday - 1)
        {
            [self handleDay:day withMonth:month row:row firstDate:firstDate];

            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            [map setValue:indexPath forKey:[NSDate dateToString:day.date dateFormatter:@"yyyy-MM-dd"]];
        }
        
        if (section == 0 && invalidStartDate) {
            NSDateComponents *nowComponents = [NSDate components:invalidStartDate];
            if (month.components.day + row - month.components.weekday + 1 < nowComponents.day) {
                day.state = MCDayStateInvalidday;
            }
        }
        if (section == maxMonths - 1 && invalidEndDate) {
            NSDateComponents *endComponents = [NSDate components:invalidEndDate];
            if (month.components.day + row - month.components.weekday + 2 > endComponents.day) {
                day.state = MCDayStateInvalidday;
            }
        }
    }
}

- (void)handleDay:(MCDayModel *)day withMonth:(MCMonthModel *)month row:(NSUInteger)row firstDate:(NSDate *)firstDate
{
    NSDate *dayDate = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay value:(row - month.components.weekday + 1) toDate:firstDate options:NSCalendarWrapComponents];
    day.date = dayDate;
    day.dateString = [NSDate dateToString:dayDate dateFormatter:@"yyyy-MM-dd"];
    day.components = [NSDate components:dayDate];
    day.chineseComponents = [NSDate componentsByChinese:dayDate];
        
    if (day.components.weekday == 1 || day.components.weekday == 7) {
        day.state = MCDayStateRestday;
    } else {
        day.state = MCDayStateWorkday;
    }
    
    day.text = [NSString stringWithFormat:@"%02ld",day.components.day];
}

- (void)handleNonEmptyDatas:(NSMutableArray *)nonEmptyDatas nonEmptyMap:(NSMutableDictionary *)nonEmptyMap datas:(NSArray *)datas
{
    for (NSInteger section = 0; section < datas.count; section++)
    {
        MCMonthModel *month = [datas objectAtIndex:section];
        
        MCMonthModel * nonEmptyMonth = [[MCMonthModel alloc] init];
        [nonEmptyDatas addObject:nonEmptyMonth];
        
        nonEmptyMonth.components = month.components;
        nonEmptyMonth.chineseComponents = month.chineseComponents;
        
        NSMutableArray *nonEmptyDays = [NSMutableArray array];
        
        NSInteger idx = 0;
        
        for (NSInteger row = 0; row < month.days.count; row++)
        {
            MCDayModel *day = [month.days objectAtIndex:row];
            
            if (day.state != MCDayStateEmpty)
            {
                [nonEmptyMap setValue:[NSIndexPath indexPathForRow:idx++ inSection:section] forKey:[NSDate dateToString:day.date dateFormatter:@"yyyy-MM-dd"]];
                [nonEmptyDays addObject:day];
            }
        }
        nonEmptyMonth.days = nonEmptyDays;
    }
}


@end
