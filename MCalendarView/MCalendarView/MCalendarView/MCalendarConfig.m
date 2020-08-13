//
//  MCalendarConfig.m
//  MCalendarView
//
//  Created by Maojunhao on 2020/4/28.
//  Copyright © 2020 Maojunhao. All rights reserved.
//

#import "MCalendarConfig.h"
#import "MConfigModel.h"

#define WEAK_SELF_MC __weak typeof(self)weakSelf = self;

@interface MCalendarConfig ()

@property (nonatomic, strong) MConfigModel * model;

@end

@implementation MCalendarConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        _model = [[MConfigModel alloc] init];
    }
    return self;
}

#pragma mark - 整个日历背景相关

- (MCConfigToColor)MCBackViewColor
{
    WEAK_SELF_MC;
    
    return ^(UIColor * color){
        weakSelf.model.backViewColor = color;
        return weakSelf;
    };
}

- (MCConfigToImage)MCBackViewImage
{
    WEAK_SELF_MC;
    
    return ^(UIImage * image){
        weakSelf.model.backViewImage = image;
        return weakSelf;
    };
}

- (MCConfigToStyle)MCStyle
{
    WEAK_SELF_MC;
    
    return ^(MCalendarStyle style){
        weakSelf.model.style = style;
        return weakSelf;
    };
}

- (MCConfigToHandleStyle)MCHandleStyle
{
    WEAK_SELF_MC;
    
    return ^(MCalendarHandleStyle style){
        weakSelf.model.handleStyle = style;
        return weakSelf;
    };
}

#pragma mark - Header (日 一 二 三 四 五 六)

- (MCConfigToFloat)MCHeaderHeight
{
    WEAK_SELF_MC;
    
    return ^(CGFloat height){
        weakSelf.model.headerHeight = height;
        return weakSelf;
    };
}

- (MCConfigToArray)MCHeaderTitles
{
    WEAK_SELF_MC;
    
    return ^(NSArray * titles){
        weakSelf.model.headerTitles = titles;
        return weakSelf;
    };
}

- (MCConfigToFont)MCHeaderFont
{
    WEAK_SELF_MC;
    
    return ^(UIFont * font){
        weakSelf.model.headerFont = font;
        return weakSelf;
    };
}

- (MCConfigToColor)MCHeaderColor
{
    WEAK_SELF_MC;
    
    return ^(UIColor * color){
        weakSelf.model.headerColor = color;
        return weakSelf;
    };
}

- (MCConfigToArray)MCHeaderFonts
{
    WEAK_SELF_MC;
    
    return ^(NSArray * fonts){
        weakSelf.model.headerFonts = fonts;
        return weakSelf;
    };
}

- (MCConfigToArray)MCHeaderColors
{
    WEAK_SELF_MC;
    
    return ^(NSArray * colors){
        weakSelf.model.headerColors = colors;
        return weakSelf;
    };
}

- (MCConfigToColor)MCHeaderBackgroundColor
{
    WEAK_SELF_MC;
    
    return ^(UIColor * color){
        weakSelf.model.headerBackgroundColor = color;
        return weakSelf;
    };
}

- (MCConfigToImage)MCHeaderBackgroundImage
{
    WEAK_SELF_MC;
    
    return ^(UIImage * image){
        weakSelf.model.headerBackgroundImage = image;
        return weakSelf;
    };
}

#pragma mark - Content （月份Header）

- (MCConfigToFloat)MCMonthHeaderHeight
{
    WEAK_SELF_MC;
    
    return ^(CGFloat height){
        weakSelf.model.monthHeaderHeight = height;
        return weakSelf;
    };
}

- (MCConfigToFont)MCMonthTitleFont
{
    WEAK_SELF_MC;
    
    return ^(UIFont * font){
        weakSelf.model.monthTitleFont = font;
        return weakSelf;
    };
}

- (MCConfigToColor)MCMonthTitleColor
{
    WEAK_SELF_MC;
    
    return ^(UIColor * color){
        weakSelf.model.monthTitleColor = color;
        return weakSelf;
    };
}

- (MCConfigToFont)MCMonthSubTitleFont
{
    WEAK_SELF_MC;
    
    return ^(UIFont * font){
        weakSelf.model.monthSubTitleFont = font;
        return weakSelf;
    };
}

- (MCConfigToColor)MCMonthSubTitleColor
{
    WEAK_SELF_MC;
    
    return ^(UIColor * color){
        weakSelf.model.monthSubTitleColor = color;
        return weakSelf;
    };
}

- (MCConfigToColor)MCMonthBackgroundColor
{
    WEAK_SELF_MC;
    
    return ^(UIColor * color){
        weakSelf.model.monthBackgroundColor = color;
        return weakSelf;
    };
}

- (MCConfigToImage)MCMonthBackgroundImage
{
    WEAK_SELF_MC;
    
    return ^(UIImage * image){
        weakSelf.model.monthBackgroundImage = image;
        return weakSelf;
    };
}

#pragma mark - Content （日历）

- (MCConfigToColor)MCBackgroundColor
{
    WEAK_SELF_MC;
    
    return ^(UIColor * color){
        weakSelf.model.backgroundColor = color;
        return weakSelf;
    };
}

- (MCConfigToColor)MCBackgroundHighLightedColor
{
    WEAK_SELF_MC;
    
    return ^(UIColor * color){
        weakSelf.model.backgroundHighLightedColor = color;
        return weakSelf;
    };
}

- (MCConfigToColor)MCBackgroundContainedColor
{
    WEAK_SELF_MC;
    
    return ^(UIColor * color){
        weakSelf.model.backgroundContainedColor = color;
        return weakSelf;
    };
}

- (MCConfigToImage)MCBackgroundImage
{
    WEAK_SELF_MC;
    
    return ^(UIImage * image){
        weakSelf.model.backgroundImage = image;
        return weakSelf;
    };
}

- (MCConfigToImage)MCBackgroundHighLightedImage
{
    WEAK_SELF_MC;
    
    return ^(UIImage * image){
        weakSelf.model.backgroundHighLightedImage = image;
        return weakSelf;
    };
}

- (MCConfigToImage)MCBackgroundContainedImage
{
    WEAK_SELF_MC;
    
    return ^(UIImage * image){
        weakSelf.model.backgroundContainedImage = image;
        return weakSelf;
    };
}


- (MCConfigToFont)MCTitleFont
{
    WEAK_SELF_MC;
    
    return ^(UIFont * font){
        weakSelf.model.titleFont = font;
        return weakSelf;
    };
}

- (MCConfigToFont)MCTitleHolidayFont
{
    WEAK_SELF_MC;
    
    return ^(UIFont * font){
        weakSelf.model.titleHolidayFont = font;
        return weakSelf;
    };
}

- (MCConfigToFont)MCTitleRestdayFont
{
    WEAK_SELF_MC;
    
    return ^(UIFont * font){
        weakSelf.model.titleRestdayFont = font;
        return weakSelf;
    };
}

- (MCConfigToFont)MCTitleInvalidFont
{
    WEAK_SELF_MC;
    
    return ^(UIFont * font){
        weakSelf.model.titleInvalidFont = font;
        return weakSelf;
    };
}

- (MCConfigToFont)MCTitleHighLightedFont
{
    WEAK_SELF_MC;
    
    return ^(UIFont * font){
        weakSelf.model.titleHighLightedFont = font;
        return weakSelf;
    };
}

- (MCConfigToColor)MCTitleColor
{
    WEAK_SELF_MC;
    
    return ^(UIColor * color){
        weakSelf.model.titleColor = color;
        return weakSelf;
    };
}

- (MCConfigToColor)MCTitleHolidayColor
{
    WEAK_SELF_MC;
    
    return ^(UIColor * color){
        weakSelf.model.titleHolidayColor = color;
        return weakSelf;
    };
}

- (MCConfigToColor)MCTitleRestdayColor
{
    WEAK_SELF_MC;
    
    return ^(UIColor * color){
        weakSelf.model.titleRestdayColor = color;
        return weakSelf;
    };
}

- (MCConfigToColor)MCTitleInvalidColor
{
    WEAK_SELF_MC;
    
    return ^(UIColor * color){
        weakSelf.model.titleInvalidColor = color;
        return weakSelf;
    };
}

- (MCConfigToColor)MCTitleHighLightedColor
{
    WEAK_SELF_MC;
    
    return ^(UIColor * color){
        weakSelf.model.titleHighLightedColor = color;
        return weakSelf;
    };
}

- (MCConfigToBOOL)MCRenderSubTitle
{
    WEAK_SELF_MC;
    
    return ^(BOOL boolValue){
        weakSelf.model.renderSubTitle = boolValue;
        return weakSelf;
    };
}

- (MCConfigToFont)MCSubTitleFont
{
    WEAK_SELF_MC;
    
    return ^(UIFont * font){
        weakSelf.model.subTitleFont = font;
        return weakSelf;
    };
}

- (MCConfigToFont)MCSubTitleHolidayFont
{
    WEAK_SELF_MC;
    
    return ^(UIFont * font){
        weakSelf.model.subTitleHolidayFont = font;
        return weakSelf;
    };
}

- (MCConfigToFont)MCSubTitleRestdayFont
{
    WEAK_SELF_MC;
    
    return ^(UIFont * font){
        weakSelf.model.subTitleRestdayFont = font;
        return weakSelf;
    };
}

- (MCConfigToFont)MCSubTitleInvalidFont
{
    WEAK_SELF_MC;
    
    return ^(UIFont * font){
        weakSelf.model.subTitleInvalidFont = font;
        return weakSelf;
    };
}

- (MCConfigToFont)MCSubTitleHighLightedFont
{
    WEAK_SELF_MC;
    
    return ^(UIFont * font){
        weakSelf.model.subTitleHighLightedFont = font;
        return weakSelf;
    };
}

- (MCConfigToColor)MCSubTitleColor
{
    WEAK_SELF_MC;
    
    return ^(UIColor * color){
        weakSelf.model.subTitleColor = color;
        return weakSelf;
    };
}

- (MCConfigToColor)MCSubTitleHolidayColor
{
    WEAK_SELF_MC;
    
    return ^(UIColor * color){
        weakSelf.model.subTitleHolidayColor = color;
        return weakSelf;
    };
}

- (MCConfigToColor)MCSubTitleRestdayColor
{
    WEAK_SELF_MC;
    
    return ^(UIColor * color){
        weakSelf.model.subTitleRestdayColor = color;
        return weakSelf;
    };
}

- (MCConfigToColor)MCSubTitleInvalidColor
{
    WEAK_SELF_MC;
    
    return ^(UIColor * color){
        weakSelf.model.subTitleInvalidColor = color;
        return weakSelf;
    };
}

- (MCConfigToColor)MCSubTitleHighLightedColor
{
    WEAK_SELF_MC;
    
    return ^(UIColor * color){
        weakSelf.model.subTitleHighLightedColor = color;
        return weakSelf;
    };
}

#pragma mark - 自定义相关

- (MCConfigToClass)MCDayClass
{
    WEAK_SELF_MC;
    
    return ^(Class cls){
        weakSelf.model.dayClass = cls;
        return weakSelf;
    };
}

- (MCConfigToString)MCDayReusableID
{
    WEAK_SELF_MC;
    
    return ^(NSString * string){
        weakSelf.model.dayReusableID = string;
        return weakSelf;
    };
}

- (MCConfigToClass)MCMonthClass
{
    WEAK_SELF_MC;
    
    return ^(Class cls){
        weakSelf.model.monthClass = cls;
        return weakSelf;
    };
}

- (MCConfigToString)MCMonthReusableID
{
    WEAK_SELF_MC;
    
    return ^(NSString * string){
        weakSelf.model.monthReusableID = string;
        return weakSelf;
    };
}

- (MCModelAsConfig)MConfigModel
{
    WEAK_SELF_MC;
    
    return ^{
        return weakSelf.model;
    };
}


@end

