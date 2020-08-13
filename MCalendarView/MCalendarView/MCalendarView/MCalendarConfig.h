//
//  MCalendarConfig.h
//  MCalendarView
//
//  Created by Maojunhao on 2020/4/28.
//  Copyright © 2020 Maojunhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCModels/MConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@class MCalendarConfig;

typedef MCalendarConfig *_Nullable(^MCConfig)(void);
typedef MCalendarConfig *_Nullable(^MCConfigToBOOL)(BOOL boolValue);
typedef MCalendarConfig *_Nullable(^MCConfigToInteger)(NSInteger number);
typedef MCalendarConfig *_Nullable(^MCConfigToFloat)(CGFloat number);
typedef MCalendarConfig *_Nullable(^MCConfigToString)(NSString * string);
typedef MCalendarConfig *_Nullable(^MCConfigToColor)(UIColor * color);
typedef MCalendarConfig *_Nullable(^MCConfigToFont)(UIFont * font);
typedef MCalendarConfig *_Nullable(^MCConfigToArray)(NSArray * array);
typedef MCalendarConfig *_Nullable(^MCConfigToImage)(UIImage * image);
typedef MCalendarConfig *_Nullable(^MCConfigToHandleStyle)(MCalendarHandleStyle style);
typedef MCalendarConfig *_Nullable(^MCConfigToStyle)(MCalendarStyle style);
typedef MCalendarConfig *_Nullable(^MCConfigToClass)(Class cls);
typedef MCalendarConfig *_Nullable(^MCConfigToString)(NSString * string);

typedef MConfigModel *_Nullable(^MCModelAsConfig)(void);

@interface MCalendarConfig : NSObject

#pragma mark - 整个日历相关
// 背景色
@property (nonatomic, copy, readonly) MCConfigToColor MCBackViewColor;
// 背景图片
@property (nonatomic, copy, readonly) MCConfigToImage MCBackViewImage;
// UI样式
@property (nonatomic, copy, readonly) MCConfigToStyle MCStyle;
// 操作方式，默认单选
@property (nonatomic, copy, readonly) MCConfigToHandleStyle MCHandleStyle;

#pragma mark - Header (日 一 二 三 四 五 六)
// 默认 44
@property (nonatomic, copy, readonly) MCConfigToFloat MCHeaderHeight;
// 默认 日 一 二 三 四 五 六
@property (nonatomic, copy, readonly) MCConfigToArray MCHeaderTitles;
// 默认 字体 15
@property (nonatomic, copy, readonly) MCConfigToFont MCHeaderFont;
// 默认 字体颜色  #333333
@property (nonatomic, copy, readonly) MCConfigToColor MCHeaderColor;
// 默认 7个文字字体都与MCHeaderFont相同，需要差异化时使用
// 修改 文字字体, 只取数组前7个，入参为 UIFont 数组
@property (nonatomic, copy, readonly) MCConfigToArray MCHeaderFonts;
// 默认 7个文字颜色都与MCHeaderFont相同，需要差异化时使用
// 修改 字体颜色, 只取数组前7个，入参为 UIFont 数组
@property (nonatomic, copy, readonly) MCConfigToArray MCHeaderColors;
// 背景色
@property (nonatomic, copy, readonly) MCConfigToColor MCHeaderBackgroundColor;
// 背景图片
@property (nonatomic, copy, readonly) MCConfigToImage MCHeaderBackgroundImage;

#pragma mark - Content （月份Header）

// 月份高度, 默认80
@property (nonatomic, copy, readonly) MCConfigToFloat MCMonthHeaderHeight;
// 月份标题字体
@property (nonatomic, copy, readonly) MCConfigToFont MCMonthTitleFont;
// 月份标题字体颜色
@property (nonatomic, copy, readonly) MCConfigToColor MCMonthTitleColor;
// 月份副标题字体
@property (nonatomic, copy, readonly) MCConfigToFont MCMonthSubTitleFont;
// 月份标题字体颜色
@property (nonatomic, copy, readonly) MCConfigToColor MCMonthSubTitleColor;
// 月份标题背景颜色
@property (nonatomic, copy, readonly) MCConfigToColor MCMonthBackgroundColor;
// 月份标题背景图片
@property (nonatomic, copy, readonly) MCConfigToImage MCMonthBackgroundImage;

#pragma mark - Content （日历）
// 日期背景色
@property (nonatomic, copy, readonly) MCConfigToColor MCBackgroundColor;
// 日期背景色 (高亮)
@property (nonatomic, copy, readonly) MCConfigToColor MCBackgroundHighLightedColor;
// 日期背景颜色 (选中的两个日期中间的日期，仅在双选时有效)
@property (nonatomic, copy, readonly) MCConfigToColor MCBackgroundContainedColor;
// 日期背景图片
@property (nonatomic, copy, readonly) MCConfigToImage MCBackgroundImage;
// 日期背景图片 (高亮)
@property (nonatomic, copy, readonly) MCConfigToImage MCBackgroundHighLightedImage;
// 日期背景颜色 (选中的两个日期中间的日期，仅在双选时有效)
@property (nonatomic, copy, readonly) MCConfigToImage MCBackgroundContainedImage;


// 日期字体
@property (nonatomic, copy, readonly) MCConfigToFont MCTitleFont;
// 日期字体 (节假日), 默认 -> MCTitleFont
@property (nonatomic, copy, readonly) MCConfigToFont MCTitleHolidayFont;
// 日期字体 (休息日), 默认 -> MCTitleFont
@property (nonatomic, copy, readonly) MCConfigToFont MCTitleRestdayFont;
// 日期字体 (不可选日期), 默认 -> MCTitleFont
@property (nonatomic, copy, readonly) MCConfigToFont MCTitleInvalidFont;
// 日期字体 (高亮), 默认 -> MCTitleFont
@property (nonatomic, copy, readonly) MCConfigToFont MCTitleHighLightedFont;

// 日期颜色
@property (nonatomic, copy, readonly) MCConfigToColor MCTitleColor;
// 日期颜色 (节假日), 默认 -> MCTitleColor
@property (nonatomic, copy, readonly) MCConfigToColor MCTitleHolidayColor;
// 日期颜色 (休息日), 默认 -> MCTitleColor
@property (nonatomic, copy, readonly) MCConfigToColor MCTitleRestdayColor;
// 日期颜色 (不可选日期), 默认 -> MCTitleColor
@property (nonatomic, copy, readonly) MCConfigToColor MCTitleInvalidColor;
// 日期颜色 (高亮), 默认 -> MCTitleColor
@property (nonatomic, copy, readonly) MCConfigToColor MCTitleHighLightedColor;

// 日期下方是否需要副标题
@property (nonatomic, readonly, copy) MCConfigToBOOL MCRenderSubTitle;
// 日期下方副标题字体
@property (nonatomic, copy, readonly) MCConfigToFont MCSubTitleFont;
// 日期下方副标题字体 (节假日)
@property (nonatomic, copy, readonly) MCConfigToFont MCSubTitleHolidayFont;
// 日期下方副标题字体 (休息日)
@property (nonatomic, copy, readonly) MCConfigToFont MCSubTitleRestdayFont;
// 日期下方副标题字体 (不可选日期)
@property (nonatomic, copy, readonly) MCConfigToFont MCSubTitleInvalidFont;
// 日期下方副标题字体 (高亮)
@property (nonatomic, copy, readonly) MCConfigToFont MCSubTitleHighLightedFont;

// 日期下方副标题字体颜色
@property (nonatomic, copy, readonly) MCConfigToColor MCSubTitleColor;
// 日期下方副标题字体颜色 (节假日)
@property (nonatomic, copy, readonly) MCConfigToColor MCSubTitleHolidayColor;
// 日期下方副标题字体颜色 (休息日)
@property (nonatomic, copy, readonly) MCConfigToColor MCSubTitleRestdayColor;
// 日期下方副标题字体颜色 (不可选日期)
@property (nonatomic, copy, readonly) MCConfigToColor MCSubTitleInvalidColor;
// 日期下方副标题字体颜色 (高亮)
@property (nonatomic, copy, readonly) MCConfigToColor MCSubTitleHighLightedColor;

#pragma mark - 自定义相关

// 自定义 Class -> 需继承 MCDayCell
@property (nonatomic, copy, readonly) MCConfigToClass MCDayClass;
// 自定义 CellReusableID
@property (nonatomic, copy, readonly) MCConfigToString MCDayReusableID;

// 自定义 月份 Header Class -> 需继承 MCMonthHeaderView
@property (nonatomic, copy, readonly) MCConfigToClass MCMonthClass;
// 自定义 HeaderReusableID
@property (nonatomic, copy, readonly) MCConfigToString MCMonthReusableID;

#pragma mark - 配置数据汇总

// 读取 MConfigModel
@property (nonatomic, copy, readonly) MCModelAsConfig MConfigModel;

@end


NS_ASSUME_NONNULL_END
