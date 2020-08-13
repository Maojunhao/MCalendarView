//
//  EMPMonthHeaderView.m
//  MCalendarView
//
//  Created by Maojunhao on 2020/4/29.
//  Copyright © 2020 Maojunhao. All rights reserved.
//

#import "EMPMonthHeaderView.h"

@implementation EMPMonthHeaderView

- (void)setMonth:(MCMonthModel *)month
{
    [super setMonth:month];
}

- (void)reloadData
{
    [super reloadData];
    
    self.backgroundColor = [UIColor grayColor];
}

//- (void)setupCustomUI
//{
//
//}

@end
