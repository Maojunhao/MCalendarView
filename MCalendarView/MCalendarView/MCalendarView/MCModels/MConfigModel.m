//
//  MConfigModel.m
//  MCalendarView
//
//  Created by Maojunhao on 2020/4/28.
//  Copyright © 2020 Maojunhao. All rights reserved.
//

#import "MConfigModel.h"

@implementation MConfigModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _handleStyle = MCalendarHandleStyleSingle;
        
        [self initBaseConfig];
        [self initHeaderConfig];
        [self initMonthConfig];
        [self initContentConfig];
    }
    return self;
}

- (void)initBaseConfig
{
    _style = MCalendarStyleVertical;
}

- (void)initHeaderConfig
{
    _headerHeight = 44;
    _headerFont = [UIFont systemFontOfSize:15];
    _headerColor = [UIColor whiteColor];
    _headerBackgroundColor = [UIColor brownColor];
}

- (void)initMonthConfig
{
    _monthHeaderHeight      = 80;
    _monthTitleFont         = [UIFont boldSystemFontOfSize:30];
    _monthTitleColor        = [UIColor whiteColor];
    _monthSubTitleFont      = [UIFont systemFontOfSize:15];
    _monthSubTitleColor     = [UIColor lightGrayColor];
    _monthBackgroundColor   = [UIColor blackColor];
}

- (void)initContentConfig
{
    _titleFont              = [UIFont systemFontOfSize:20];
    _titleHolidayFont       = _titleFont;
    _titleRestdayFont       = _titleFont;
    _titleInvalidFont       = _titleFont;
    _titleHighLightedFont   = _titleFont;
    
    _titleColor             = [UIColor blackColor];
    _titleHolidayColor      = _titleColor;
    _titleRestdayColor      = _titleColor;
    _titleInvalidColor      = [UIColor lightGrayColor];
    _titleHighLightedColor  = [UIColor redColor];
    
    _backgroundColor        = [UIColor clearColor];
    _backgroundContainedColor = [UIColor orangeColor];
    _backgroundHighLightedColor = [UIColor redColor];
    
    _renderSubTitle         = YES;
    _subTitleFont           = [UIFont systemFontOfSize:12];
    _subTitleHolidayFont    = _subTitleFont;
    _subTitleRestdayFont    = _subTitleFont;
    _subTitleInvalidFont    = _subTitleFont;
    _subTitleHighLightedFont= _subTitleFont;

    _subTitleColor          = [UIColor lightGrayColor];
    _subTitleHolidayColor   = _subTitleColor;
    _subTitleRestdayColor   = _subTitleColor;
    _subTitleInvalidColor   = _subTitleColor;
    _subTitleHighLightedColor= _subTitleColor;
}



@end
