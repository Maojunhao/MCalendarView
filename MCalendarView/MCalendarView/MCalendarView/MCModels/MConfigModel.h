//
//  MConfigModel.h
//  MCalendarView
//
//  Created by Maojunhao on 2020/4/28.
//  Copyright © 2020 Maojunhao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    MCalendarStyleVertical,
    MCalendarStyleHorizontal,
} MCalendarStyle;

typedef enum : NSUInteger {
    MCalendarHandleStyleSingle,
    MCalendarHandleStyleDouble,
} MCalendarHandleStyle;

@interface MConfigModel : NSObject

#pragma mark - 整个日历相关
// 背景色
@property (nonatomic, strong) UIColor * backViewColor;
// 背景图片
@property (nonatomic, strong) UIImage * backViewImage;
// UI样式
@property (nonatomic, assign) MCalendarStyle style;
// 操作方式，默认单选
@property (nonatomic, assign) MCalendarHandleStyle handleStyle;

#pragma mark - Header (日 一 二 三 四 五 六)
@property (nonatomic, assign) CGFloat   headerHeight;
@property (nonatomic, strong) NSArray * headerTitles;
@property (nonatomic, strong) UIFont  * headerFont;
@property (nonatomic, strong) UIColor * headerColor;
@property (nonatomic, strong) NSArray * headerFonts;
@property (nonatomic, strong) NSArray * headerColors;
@property (nonatomic, strong) UIColor * headerBackgroundColor;
@property (nonatomic, strong) UIImage * headerBackgroundImage;

#pragma mark - Content （月份Header）

@property (nonatomic, assign) CGFloat   monthHeaderHeight;
@property (nonatomic, strong) UIFont  * monthTitleFont;
@property (nonatomic, strong) UIColor * monthTitleColor;
@property (nonatomic, strong) UIFont  * monthSubTitleFont;
@property (nonatomic, strong) UIColor * monthSubTitleColor;
@property (nonatomic, strong) UIColor * monthBackgroundColor;
@property (nonatomic, strong) UIImage * monthBackgroundImage;

#pragma mark - Content （日历）
@property (nonatomic, strong) UIColor * backgroundColor;
@property (nonatomic, strong) UIColor * backgroundHighLightedColor;
@property (nonatomic, strong) UIColor * backgroundContainedColor;
@property (nonatomic, strong) UIImage * backgroundImage;
@property (nonatomic, strong) UIImage * backgroundHighLightedImage;
@property (nonatomic, strong) UIImage * backgroundContainedImage;

// 日期字体
@property (nonatomic, strong) UIFont * titleFont;
@property (nonatomic, strong) UIFont * titleHolidayFont;
@property (nonatomic, strong) UIFont * titleRestdayFont;
@property (nonatomic, strong) UIFont * titleInvalidFont;
@property (nonatomic, strong) UIFont * titleHighLightedFont;

@property (nonatomic, strong) UIColor * titleColor;
@property (nonatomic, strong) UIColor * titleHolidayColor;
@property (nonatomic, strong) UIColor * titleRestdayColor;
@property (nonatomic, strong) UIColor * titleInvalidColor;
@property (nonatomic, strong) UIColor * titleHighLightedColor;

@property (nonatomic, assign) BOOL    renderSubTitle;
@property (nonatomic, strong) UIFont  * subTitleFont;
@property (nonatomic, strong) UIFont  * subTitleHolidayFont;
@property (nonatomic, strong) UIFont  * subTitleRestdayFont;
@property (nonatomic, strong) UIFont  * subTitleInvalidFont;
@property (nonatomic, strong) UIFont  * subTitleHighLightedFont;

@property (nonatomic, strong) UIColor * subTitleColor;
@property (nonatomic, strong) UIColor * subTitleHolidayColor;
@property (nonatomic, strong) UIColor * subTitleRestdayColor;
@property (nonatomic, strong) UIColor * subTitleInvalidColor;
@property (nonatomic, strong) UIColor * subTitleHighLightedColor;

#pragma mark - 自定义相关

@property (nonatomic, assign) Class dayClass;
@property (nonatomic, copy)   NSString * dayReusableID;

@property (nonatomic, assign) Class monthClass;
@property (nonatomic, copy)   NSString * monthReusableID;

@property (nonatomic, copy) void (^reloadData)(void);

@end

NS_ASSUME_NONNULL_END
