//
//  MCHeaderView.h
//  MCalendarView
//
//  Created by Maojunhao on 2020/4/21.
//  Copyright © 2020 Maojunhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCHeaderView : UIView

@property (nonatomic, strong) MConfigModel * model;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
