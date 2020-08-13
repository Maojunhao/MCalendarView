//
//  MCDayModel.h
//  MCalendarView
//
//  Created by Maojunhao on 2020/4/21.
//  Copyright © 2020 Maojunhao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, MCDayState) {
    MCDayStateWorkday                   = 0,      // 工作日，周一~周五
    MCDayStateRestday                   = 1 << 0, // 休息日，周六、周天
    MCDayStateHoliday                   = 1 << 1, // 法定节假日
    MCDayStateChineseHoliday            = 1 << 2, // 中国节日
    MCDayStateChineseThrottle           = 1 << 3, // 中国节气
    MCDayStateGregorianHoliday          = 1 << 4, // 外国节日
    MCDayStateInvalidday                = 1 << 5, // 不可点击日期
    MCDayStateEmpty                     = 1 << 6, // 日历每月开头结尾空白部分
};

typedef NS_OPTIONS(NSUInteger, MCRestState) {
    MCHolidayStateDefault                    = 0,      // 默认
    MCHolidayStateRest                       = 1 << 0, // 休息
    MCHolidayStateOvertime                   = 1 << 1, // 加班
};

typedef NS_OPTIONS(NSUInteger, MCDayHandleState) {
    MCDayHandleStateDefault                  = 0,      // 默认
    MCDayHandleStateSelected                 = 1 << 0, // 选中
    MCDayHandleStateContained                = 1 << 1, // 包含
    MCDayHandleStateStarted                  = 1 << 2, // 开始（双选有效）
    MCDayHandleStateEnded                    = 1 << 3, // 结束（双选有效）
    MCDayHandleStateStartAndEnd              = 1 << 4, // 开始、结束在同一天（双选有效）
    MCDayHandleStateInvalid                  = 1 << 5, // 不可用
};

@interface MCDayModel : NSObject

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, copy)   NSString * dateString;

@property (nonatomic, strong) NSDateComponents *components;

@property (nonatomic, strong) NSDateComponents *chineseComponents;

@property (nonatomic, assign) MCDayState state;

@property (nonatomic, assign) MCRestState restState;

@property (nonatomic, assign) MCDayHandleState handleState;

// 法定节假日
@property (nonatomic, copy) NSString *holidayName;
// 中国节日
@property (nonatomic, copy) NSString *chineseHolidayName;
// 中国节气
@property (nonatomic, copy) NSString *throttleName;
// 外国节日
@property (nonatomic, copy) NSString *gregorianHolidayName;

// 默认显示日期
@property (nonatomic, copy) NSString * text;
// 子标题
@property (nonatomic, copy) NSString * subText;

@end

@interface MCMonthModel : NSObject

@property (nonatomic, strong) NSDateComponents *components;

@property (nonatomic, strong) NSDateComponents *chineseComponents;

@property (nonatomic, strong) NSArray <MCDayModel *> * days;

// 默认显示日期
@property (nonatomic, copy) NSString * text;
// 子标题
@property (nonatomic, copy) NSString * subText;

@end

NS_ASSUME_NONNULL_END
