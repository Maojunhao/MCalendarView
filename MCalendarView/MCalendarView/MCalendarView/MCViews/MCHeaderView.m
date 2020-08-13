//
//  MCHeaderView.m
//  MCalendarView
//
//  Created by Maojunhao on 2020/4/21.
//  Copyright © 2020 Maojunhao. All rights reserved.
//

#import "MCHeaderView.h"

@interface MCHeaderView ()

@property (nonatomic, strong) UIImageView * backgroundImageView;

@end

@implementation MCHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.backgroundImageView.frame.size.width, self.backgroundImageView.frame.size.height)];
    [self addSubview:self.backgroundImageView];
    
    NSArray *weekNames = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    CGFloat space = self.bounds.size.width / 7.0f;
        
    [weekNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(space * idx, 0, space, 44)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [weekNames objectAtIndex:idx];
        label.tag = 10000 + idx;
        [self addSubview:label];
    }];
}

- (void)reloadData
{
    self.backgroundColor = self.model.headerBackgroundColor;
    self.backgroundImageView.image = self.model.backgroundImage;
    
    for (NSUInteger idx = 0; idx < 7; idx++) {
        UILabel * label = (UILabel *)[self viewWithTag:idx+10000];
        label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, self.model.headerHeight);
        label.font = self.model.headerFont;
        label.textColor = self.model.headerColor;
        
        [self reloadTitles:label idx:idx];
        [self reloadFonts:label idx:idx];
        [self reloadColors:label idx:idx];
    }
}

- (void)reloadTitles:(UILabel *)label idx:(NSUInteger)idx
{
    if (!self.model.headerTitles)   return;
    if (self.model.headerTitles.count <= idx) return;
    label.text = [self.model.headerTitles objectAtIndex:idx];
}

- (void)reloadFonts:(UILabel *)label idx:(NSUInteger)idx
{
    if (!self.model.headerFonts)   return;
    if (self.model.headerFonts.count <= idx) return;
    label.font = [self.model.headerFonts objectAtIndex:idx];
}

- (void)reloadColors:(UILabel *)label idx:(NSUInteger)idx
{
    if (!self.model.headerColors)   return;
    if (self.model.headerColors.count <= idx) return;
    label.textColor = [self.model.headerColors objectAtIndex:idx];
}

@end
