//
//  MCMonthHeaderView.m
//  MCalendarView
//
//  Created by Maojunhao on 2020/4/21.
//  Copyright © 2020 Maojunhao. All rights reserved.
//

#import "MCMonthHeaderView.h"

@interface MCMonthHeaderView ()

@property (nonatomic, strong) UILabel * monthLabel;

@property (nonatomic, strong) UILabel * subLabel;

@property (nonatomic, strong) UIImageView * backgroundImageView;

@property (nonatomic, assign) BOOL defaultUI;

@end

@implementation MCMonthHeaderView

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

- (void)setupUI
{
    self.monthLabel = [[UILabel alloc] init];
    self.subLabel   = [[UILabel alloc] init];
    self.backgroundImageView = [[UIImageView alloc] init];
    
    [self addSubview:self.monthLabel];
    [self addSubview:self.subLabel];
    [self addSubview:self.backgroundImageView];
}

- (void)layoutSubviews
{
    if (!self.defaultUI) { return; }
    
    self.backgroundImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.monthLabel.frame = CGRectMake(30, 10, 240, 40);
    self.subLabel.frame = CGRectMake(30, 50, self.frame.size.width - 60, 20);
}

- (void)setModel:(MConfigModel *)model
{
    _model = model;
}

- (void)setMonth:(MCMonthModel *)month
{
    _month = month;
    
    _month.text = [NSString stringWithFormat:@"%ld年%ld月", month.components.year, month.components.month];
    _month.subText = [NSString stringWithFormat:@"我是%@的子标题", _month.text];
}

- (void)reloadData
{
    if (!self.defaultUI) { return; }
    
    self.monthLabel.text = self.month.text;
    self.subLabel.text = self.month.subText;
    
    self.backgroundColor = self.model.monthBackgroundColor;
    self.backgroundImageView.image = self.model.monthBackgroundImage;
    
    self.monthLabel.font = self.model.monthTitleFont;
    self.monthLabel.textColor = self.model.monthTitleColor;
    
    self.subLabel.font = self.model.monthSubTitleFont;
    self.subLabel.textColor = self.model.monthSubTitleColor;
}

#pragma mark - 自定义

- (void)clearUI
{
    if (self.defaultUI) { return; }
    
    [self.backgroundImageView removeFromSuperview];
    [self.monthLabel removeFromSuperview];
    [self.subLabel removeFromSuperview];
}

- (void)setupCustomUI
{
    self.defaultUI = YES;
}

@end
