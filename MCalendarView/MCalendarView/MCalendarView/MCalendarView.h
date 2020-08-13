//
//  MCalendarView.h
//  MCalendarView
//
//  Created by Maojunhao on 2020/4/21.
//  Copyright © 2020 Maojunhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCalendarConfig.h"

@class MCDayModel;

NS_ASSUME_NONNULL_BEGIN

@interface MCalendarView : UIView

@property (nonatomic, strong) MCalendarConfig * config;

// 默认 YES, 返回 NO 时，当前点击日期不会高亮
@property (nonatomic, copy) BOOL (^MCalendarViewCanTouchBlock)(MCalendarHandleStyle style, MCDayModel * day);
/**
 * 单选模式 :
 * style = MCalendarHandleStyleSingle ,  startDay 正常返回 ,  endDay 返回 nil
 * 双选模式：
 * style = MCalendarHandleStyleDouble, 第一次点击 startDay 正常返回，endDay 返回 nil
 * 第二次点击，startDay 正常返回, endDay 正常返回
 */
@property (nonatomic, copy) void (^MCalendarViewTouchBlock)(MCalendarHandleStyle style, MCDayModel * startDay, MCDayModel * endDay);

- (void)reloadData;

@end


NS_ASSUME_NONNULL_END
