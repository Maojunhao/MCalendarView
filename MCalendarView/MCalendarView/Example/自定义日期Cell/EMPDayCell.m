//
//  EMPDayCellCollectionViewCell.m
//  MCalendarView
//
//  Created by Maojunhao on 2020/4/29.
//  Copyright © 2020 Maojunhao. All rights reserved.
//

#import "EMPDayCell.h"

@implementation EMPDayCell

// 数据源
- (void)setDay:(MCDayModel *)day
{
    [super setDay:day];
    
    self.backgroundColor = [UIColor whiteColor];
//    self.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0f green:arc4random()%256/255.0f blue:arc4random()%256/255.0f alpha:1];
}

//// 自定义UI
//- (void)setupCustomUI
//{
//
//}

@end
