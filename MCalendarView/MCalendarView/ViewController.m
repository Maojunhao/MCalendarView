//
//  ViewController.m
//  MCalendarView
//
//  Created by Maojunhao on 2020/4/21.
//  Copyright © 2020 Maojunhao. All rights reserved.
//

#import "ViewController.h"
#import "MCalendarView.h"
#import "EMPDayCell.h"
#import "EMPMonthHeaderView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MCalendarView * calendarView = [[MCalendarView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 44)];
    [self.view addSubview:calendarView];
    
    [self setupHorizontalView:calendarView];
}

- (void)setupVerticalView:(MCalendarView *)calendarView
{
    NSArray * headerColors = @[[UIColor redColor],[UIColor whiteColor],[UIColor whiteColor],[UIColor whiteColor],[UIColor whiteColor],[UIColor whiteColor],[UIColor redColor]];
    NSArray * headerTitles = @[@"Sun", @"Mon", @"Tus", @"Thr", @"Fou", @"Fri", @"Sat"];
    
    calendarView.config.MCHeaderColors(headerColors)
    .MCHandleStyle(MCalendarHandleStyleSingle)
    .MCStyle(MCalendarStyleVertical)
    .MCHeaderTitles(headerTitles)
    .MCDayReusableID(@"test")
    .MCDayClass([EMPDayCell class])
    .MCMonthClass([EMPMonthHeaderView class])
    .MCMonthReusableID(@"testHeader");
    
    [calendarView reloadData];
    
    calendarView.MCalendarViewTouchBlock = ^(MCalendarHandleStyle style, MCDayModel * _Nonnull startDay, MCDayModel * _Nonnull endDay) {
        NSLog(@"\nStyle = %ld, startDay = %@, endDay = %@\n", style, startDay.dateString, endDay.dateString);
    };
    
    calendarView.MCalendarViewCanTouchBlock = ^BOOL(MCalendarHandleStyle style, MCDayModel * _Nonnull day) {
        return YES;
    };
}

- (void)setupHorizontalView:(MCalendarView *)calendarView
{
    NSArray * headerColors = @[[UIColor redColor],[UIColor whiteColor],[UIColor whiteColor],[UIColor whiteColor],[UIColor whiteColor],[UIColor whiteColor],[UIColor redColor]];
    NSArray * headerTitles = @[@"Sun", @"Mon", @"Tus", @"Thr", @"Fou", @"Fri", @"Sat"];
    
    calendarView.config.MCHeaderColors(headerColors)
    .MCHandleStyle(MCalendarHandleStyleSingle)
    .MCStyle(MCalendarStyleHorizontal)
    .MCHeaderTitles(headerTitles)
    .MCDayReusableID(@"test")
    .MCDayClass([EMPDayCell class])
    .MCMonthClass([EMPMonthHeaderView class])
    .MCMonthReusableID(@"testHeader");
    
    [calendarView reloadData];
    
    calendarView.MCalendarViewTouchBlock = ^(MCalendarHandleStyle style, MCDayModel * _Nonnull startDay, MCDayModel * _Nonnull endDay) {
        NSLog(@"\nStyle = %ld, startDay = %@, endDay = %@\n", style, startDay.dateString, endDay.dateString);
    };
    
    calendarView.MCalendarViewCanTouchBlock = ^BOOL(MCalendarHandleStyle style, MCDayModel * _Nonnull day) {
        return YES;
    };
}


@end
