//
//  MCDayCell.m
//  MCalendarView
//
//  Created by Maojunhao on 2020/4/21.
//  Copyright © 2020 Maojunhao. All rights reserved.
//

#import "MCDayCell.h"

@interface MCDayCell ()

@property (nonatomic, strong) UIImageView * backgroundImageView;

@property (nonatomic, strong) UILabel * dayLabel;

@property (nonatomic, strong) UILabel * subLabel;

@property (nonatomic, strong) UIImageView * tagImageView;

@property (nonatomic, assign) BOOL defaultUI;

@end

@implementation MCDayCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self setupCustomUI];
        [self clearUI];
    }
    return self;
}

- (void)layoutSubviews
{
    if (!self.defaultUI) { return; }
    
    self.backgroundImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.dayLabel.frame = CGRectMake(0, 10, self.frame.size.width, 20);
    self.subLabel.frame = CGRectMake(0, 35, self.frame.size.width, 15);
    self.tagImageView.frame = CGRectMake(self.frame.size.width - 20, 5, 10, 10);
}

- (void)setupUI
{
    self.backgroundImageView    = [[UIImageView alloc] init];
    self.dayLabel               = [[UILabel alloc] init];
    self.subLabel               = [[UILabel alloc] init];
    self.tagImageView           = [[UIImageView alloc] init];
    
    [self.contentView addSubview:self.backgroundImageView];
    [self.contentView addSubview:self.dayLabel];
    [self.contentView addSubview:self.subLabel];
    [self.contentView addSubview:self.tagImageView];
    
    self.dayLabel.textAlignment = NSTextAlignmentCenter;
    self.subLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setModel:(MConfigModel *)model
{
    _model = model;
}

- (void)setDay:(MCDayModel *)day
{
    _day = day;
    
    day.subText = [NSString stringWithFormat:@"子标题%@", day.text];
}

- (void)reloadData
{
    if (!self.defaultUI) { return; }
    
    [self reloadBackgroundData];
    [self reloadUIData];
}

- (void)reloadBackgroundData
{
    switch (self.day.handleState) {
        case MCDayHandleStateDefault:{
            [self updateBackgroundWithNormalState];
        }
            break;
        case MCDayHandleStateSelected:
        case MCDayHandleStateStarted:
        case MCDayHandleStateEnded:
        case MCDayHandleStateStartAndEnd:{
            [self updateBackgroundWithHighLightedState];
        }
            break;
        case MCDayHandleStateContained:{
            [self updateBackgroundWithContainedState];
        }
            break;
        case MCDayHandleStateInvalid:{
            [self updateBackgroundWithHighLightedState];
        }
            break;
            
        default:
            break;
    }
}

- (void)reloadUIData
{
    self.dayLabel.text = self.day.text;
    self.subLabel.text = self.day.subText;
    self.subLabel.hidden = !self.model.renderSubTitle;
    
    switch (self.day.state) {
        case MCDayStateWorkday: {
            [self updateUIWithNormalState];
        }
            break;
        case MCDayStateRestday: {
            [self updateUIWithRestdayState];
        }
            break;
        case MCDayStateHoliday:
        case MCDayStateChineseHoliday:
        case MCDayStateChineseThrottle:
        case MCDayStateGregorianHoliday: {
            [self updateUIWithHolidayState];
        }
            break;
        case MCDayStateInvalidday: {
            [self updateUIWithInvalidState];
            self.subLabel.hidden = YES;
        }
            break;
        case MCDayStateEmpty: {
            self.subLabel.hidden = YES;
        }
            break;
        default:
            break;
    }
}

- (void)updateBackgroundWithNormalState
{
    self.contentView.backgroundColor = self.model.backgroundColor;
    self.backgroundImageView.image = self.model.backgroundImage;
}

- (void)updateBackgroundWithHighLightedState
{
    self.contentView.backgroundColor = self.model.backgroundHighLightedColor;
    self.backgroundImageView.image = self.model.backgroundHighLightedImage;
}

- (void)updateBackgroundWithContainedState
{
    self.contentView.backgroundColor = self.model.backgroundContainedColor;
    self.backgroundImageView.image = self.model.backgroundContainedImage;
}

- (void)updateUIWithNormalState
{
    self.dayLabel.font = self.model.titleFont;
    self.dayLabel.textColor = self.model.titleColor;
    
    if (!self.model.renderSubTitle) return;
    self.subLabel.font = self.model.subTitleFont;
    self.subLabel.textColor = self.model.subTitleColor;
}

- (void)updateUIWithHolidayState
{
    self.dayLabel.font = self.model.titleHolidayFont;
    self.dayLabel.textColor = self.model.titleHolidayColor;
    
    if (!self.model.renderSubTitle) return;
    self.subLabel.font = self.model.subTitleHolidayFont;
    self.subLabel.textColor = self.model.subTitleHolidayColor;
}

- (void)updateUIWithRestdayState
{
    self.dayLabel.font = self.model.titleRestdayFont;
    self.dayLabel.textColor = self.model.titleRestdayColor;
    
    if (!self.model.renderSubTitle) return;
    self.subLabel.font = self.model.subTitleRestdayFont;
    self.subLabel.textColor = self.model.subTitleRestdayColor;
}

- (void)updateUIWithHighLightedState
{
    self.dayLabel.font = self.model.titleFont;
    self.dayLabel.textColor = self.model.titleColor;
    
    if (!self.model.renderSubTitle) return;
    self.subLabel.font = self.model.subTitleHighLightedFont;
    self.subLabel.textColor = self.model.subTitleHighLightedColor;
}

- (void)updateUIWithInvalidState
{
    self.dayLabel.font = self.model.titleInvalidFont;
    self.dayLabel.textColor = self.model.titleInvalidColor;
    
    if (!self.model.renderSubTitle) return;
    self.subLabel.font = self.model.subTitleInvalidFont;
    self.subLabel.textColor = self.model.subTitleInvalidColor;
}

#pragma mark - 自定义

- (void)clearUI
{
    if (self.defaultUI) { return; }
    
    [self.backgroundImageView removeFromSuperview];
    [self.dayLabel removeFromSuperview];
    [self.subLabel removeFromSuperview];
    [self.tagImageView removeFromSuperview];
}

- (void)setupCustomUI
{
    self.defaultUI = YES;
}

@end
