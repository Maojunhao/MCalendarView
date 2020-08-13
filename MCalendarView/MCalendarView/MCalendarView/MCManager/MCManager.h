//
//  MCManager.h
//  MCalendarView
//
//  Created by Maojunhao on 2020/4/21.
//  Copyright © 2020 Maojunhao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCManager : NSObject

@property (nonatomic, strong) NSDictionary <NSString*,NSIndexPath *> *map;

@property (nonatomic, strong) NSDictionary <NSString*,NSIndexPath *> *noEmptyMap;

+ (instancetype)manager;

// 从当前月份开始，到多少个月之后数据，默认从今天起一年数据
- (NSArray *)initializeDatasWithStartDate:(NSDate *)startDate maxMonth:(NSInteger)maxMonths;

@end

NS_ASSUME_NONNULL_END
