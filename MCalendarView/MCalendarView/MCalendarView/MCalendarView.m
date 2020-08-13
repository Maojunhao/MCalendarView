//
//  MCalendarView.m
//  MCalendarView
//
//  Created by Maojunhao on 2020/4/21.
//  Copyright © 2020 Maojunhao. All rights reserved.
//

#import "MCalendarView.h"
#import "MCHeaderView.h"
#import "MCVerticalView.h"
#import "MCHorizontalView.h"

#import "MCManager.h"

@interface MCalendarView ()

@property (nonatomic, strong) MCHeaderView * headerView;

@property (nonatomic, strong) MCVerticalView * verticalView;

@property (nonatomic, strong) MCHorizontalView * horizontalView;

@end

@implementation MCalendarView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.config = [[MCalendarConfig alloc] init];
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self setupHeaderView];
    [self setupVerticalView];
}

- (void)setupHeaderView
{
    self.headerView = [[MCHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    [self addSubview:self.headerView];
}

- (void)setupVerticalView
{
    if (self.verticalView) { return; }
    [self clearContentView];
    self.verticalView = [[MCVerticalView alloc] initWithFrame:CGRectMake(0, 44, self.frame.size.width, self.frame.size.height - 44)];
    [self addSubview:self.verticalView];
}

- (void)setupHorizontalView
{
    if (self.horizontalView) { return; }
    [self clearContentView];
    self.horizontalView = [[MCHorizontalView alloc] initWithFrame:CGRectMake(0, 44, self.frame.size.width, self.frame.size.height - 44)];
    [self addSubview:self.horizontalView];
}

- (void)clearContentView
{
    if (self.verticalView) {
        [self.verticalView removeFromSuperview];
        self.verticalView = nil;
    }
    
    if (self.horizontalView) {
        [self.horizontalView removeFromSuperview];
        self.horizontalView = nil;
    }
}

- (void)reloadData
{
    MConfigModel * model = self.config.MConfigModel();
    
    // Header
    self.headerView.model = model;
    [self.headerView reloadData];
    
    // Content
    NSArray * datas = [[MCManager manager] initializeDatasWithStartDate:[NSDate date] maxMonth:12];
    switch (model.style) {
        case MCalendarStyleVertical:
        {
            [self setupVerticalView];
            self.verticalView.model = model;
            self.verticalView.datas = datas;
            [self.verticalView reloadData];
        }
            break;
        case MCalendarStyleHorizontal:
        {
            [self resizeHorizontalView];
            [self setupHorizontalView];
            self.horizontalView.model = model;
            self.horizontalView.datas = datas;
            [self.horizontalView reloadData];
        }
            break;
        default:
            break;
    }
}

- (void)setMCalendarViewTouchBlock:(void (^)(MCalendarHandleStyle, MCDayModel * _Nonnull, MCDayModel * _Nonnull))MCalendarViewTouchBlock
{
    _MCalendarViewTouchBlock = MCalendarViewTouchBlock;
    
    if (self.verticalView) { self.verticalView.MCVerticalViewTouchBlock = MCalendarViewTouchBlock; }
    if (self.horizontalView) { self.horizontalView.MCHorizontalViewTouchBlock = MCalendarViewTouchBlock; }
}

- (void)setMCalendarViewCanTouchBlock:(BOOL (^)(MCalendarHandleStyle, MCDayModel * _Nonnull))MCalendarViewCanTouchBlock
{
    _MCalendarViewCanTouchBlock = MCalendarViewCanTouchBlock;
    
    if (self.verticalView) { self.verticalView.MCVerticalViewCanTouchBlock = MCalendarViewCanTouchBlock; }
    if (self.horizontalView) { self.horizontalView.MCHorizontalViewCanTouchBlock = MCalendarViewCanTouchBlock; }
}

- (void)resizeHorizontalView
{
    CGFloat height = 0.0f;
    MConfigModel * model = self.config.MConfigModel();
    height += model.headerHeight;
    height += model.monthHeaderHeight;
    height += (self.frame.size.width / 7.0f) * 6;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

@end


