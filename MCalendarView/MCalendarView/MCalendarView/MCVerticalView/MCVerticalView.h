//
//  MCVerticalView.h
//  MCalendarView
//
//  Created by Maojunhao on 2020/4/21.
//  Copyright © 2020 Maojunhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MConfigModel.h"

@class MCDayModel;

NS_ASSUME_NONNULL_BEGIN

@interface MCVerticalView : UIView

@property (nonatomic, strong) MConfigModel * model;

@property (strong, nonatomic) NSArray * datas;

// 默认 YES, 返回 NO 时，当前点击日期不会高亮
@property (nonatomic, copy) BOOL (^MCVerticalViewCanTouchBlock)(MCalendarHandleStyle style, MCDayModel * day);
/**
 * 单选模式 :
 * style = MCalendarHandleStyleSingle ,  startDay 正常返回 ,  endDay 返回 nil
 * 双选模式：
 * style = MCalendarHandleStyleDouble, 第一次点击 startDay 正常返回，endDay 返回 nil
 * 第二次点击，startDay 正常返回, endDay 正常返回
 */
@property (nonatomic, copy) void (^MCVerticalViewTouchBlock)(MCalendarHandleStyle style, MCDayModel * startDay, MCDayModel * endDay);

- (void)reloadData;

- (void)defaultSelectedAtStartIndexPath:(NSIndexPath *)startIndexPath endIndexPath:(NSIndexPath *)endIndexPath;

@end

NS_ASSUME_NONNULL_END
