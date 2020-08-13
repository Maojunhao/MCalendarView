//
//  MCHorizontalCell.h
//  MCalendarView
//
//  Created by Maojunhao on 2020/4/21.
//  Copyright © 2020 Maojunhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MConfigModel.h"
#import "MCDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCHorizontalCell : UICollectionViewCell

@property (nonatomic, strong) MConfigModel * model;

@property (nonatomic, assign) NSInteger section;

@property (nonatomic, strong) MCMonthModel * month;

/** 获取开始点，结束点 **/

@property (nonatomic, copy) NSIndexPath *(^startIndexPath)(void);

@property (nonatomic, copy) NSIndexPath *(^endIndexPath)(void);

/** 更改开始点，结束点 **/

@property (nonatomic, copy) void (^modifyStartIndexPath)(NSIndexPath * __nullable indexPath);

@property (nonatomic, copy) void (^modifyEndIndexPath)(NSIndexPath * __nullable indexPath);

/** 双选时包含的日期 **/

@property (nonatomic, copy) NSArray <NSIndexPath *> *(^containedIndexPaths)(void);

///** 选择完成 **/
//
//@property (nonatomic, copy) void (^calendarContentHorizontalCellSingleDayCompleteBlock)(void);
//
//@property (nonatomic, copy) BOOL (^calendarContentHorizontalCellShouldSingleDayCompleteBlock)(NSIndexPath * indexPath);
//
//@property (nonatomic, copy) void (^calendarContentHorizontalCellDoubleDayCompleteBlock)(void);

// 默认 YES, 返回 NO 时，当前点击日期不会高亮
@property (nonatomic, copy) BOOL (^MCHorizontalCellCanTouchBlock)(NSIndexPath * indexPath);
/**
 * 单选模式 :
 * style = MCalendarHandleStyleSingle ,  startDay 正常返回 ,  endDay 返回 nil
 * 双选模式：
 * style = MCalendarHandleStyleDouble, 第一次点击 startDay 正常返回，endDay 返回 nil
 * 第二次点击，startDay 正常返回, endDay 正常返回
 */
@property (nonatomic, copy) void (^MCHorizontalCellTouchBlock)(void);

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
