//
//  MCDayCell.h
//  MCalendarView
//
//  Created by Maojunhao on 2020/4/21.
//  Copyright © 2020 Maojunhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MConfigModel.h"
#import "MCDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCDayCell : UICollectionViewCell

@property (nonatomic, strong) MConfigModel * model;

@property (nonatomic, strong) MCDayModel * day;

- (void)reloadData;

// 自定义需重写这个方法，实现自定义UI
- (void)setupCustomUI;

@end

NS_ASSUME_NONNULL_END
