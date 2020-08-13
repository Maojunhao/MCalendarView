//
//  MCHorizontalCell.m
//  MCalendarView
//
//  Created by Maojunhao on 2020/4/21.
//  Copyright © 2020 Maojunhao. All rights reserved.
//

#import "MCHorizontalCell.h"
#import "MCDataModel.h"
#import "MCDayCell.h"
#import "MCMonthHeaderView.h"

static NSString * const MC_ID_HORIZONTAL_CELL   = @"MC_HORIZONTAL_CELL_DAY";
static NSString * const MC_ID_HORIZONTAL_HEADER = @"MC_HORIZONTAL_CELL_HEADER";

@interface MCHorizontalCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView  * collectionView;

@property (nonatomic, assign) CGFloat             itemWidth;

@end

@implementation MCHorizontalCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0f green:arc4random()%256/255.0f blue:arc4random()%256/255.0f alpha:1];
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self setupCollectionView];
    [self configCollectionItemWidth];
}

- (void)setupCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing      = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    //    self.collectionView.pagingEnabled = YES;
    self.collectionView.scrollEnabled = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self.collectionView registerClass:[MCDayCell class] forCellWithReuseIdentifier:MC_ID_HORIZONTAL_CELL];
    [self.collectionView registerClass:[MCMonthHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MC_ID_HORIZONTAL_HEADER];
    
    [self addSubview:self.collectionView];
}

- (void)configCollectionItemWidth
{
    CGFloat itemWidth = self.collectionView.frame.size.width / 7.0f;
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                       scale:2
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:YES];
    
    NSDecimalNumber * number = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lf",itemWidth]];
    number = [number decimalNumberByRoundingAccordingToBehavior:roundUp];
    
    self.itemWidth  = number.floatValue;
}

#pragma mark - Action

- (void)reloadData
{
    [self reloadCustomData];
    [self.collectionView reloadData];
    
    self.backgroundColor = self.model.backgroundColor;
    if (!self.startIndexPath) {
        return;
    }
}

- (void)reloadCustomData
{
    if (self.model.dayClass && self.model.dayReusableID) {
        [self.collectionView registerClass:self.model.dayClass forCellWithReuseIdentifier:self.model.dayReusableID];
    }
    
    if (self.model.monthClass && self.model.monthReusableID) {
        [self.collectionView registerClass:self.model.monthClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:self.model.monthReusableID];
    }
}

#pragma mark - CollectionView

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.bounds.size.width, self.model.monthHeaderHeight);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.month.days.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        // 先检查自定义
        if (self.model.monthReusableID) {
            MCMonthHeaderView * customHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:self.model.monthReusableID forIndexPath:indexPath];
            if ([customHeaderView isKindOfClass:[MCMonthHeaderView class]]) {
                customHeaderView.model = self.model;
                customHeaderView.month = self.month;
                [customHeaderView reloadData];
                return customHeaderView;
            }
        }
        
        MCMonthHeaderView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:MC_ID_HORIZONTAL_HEADER forIndexPath:indexPath];
        headerView.model = self.model;
        headerView.month = self.month;
        [headerView reloadData];
        return headerView;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MCDayModel * day = [self.month.days objectAtIndex:indexPath.row];
    // 先检查自定义
    if (self.model.dayReusableID) {
        MCDayCell * customCell = [collectionView dequeueReusableCellWithReuseIdentifier:self.model.dayReusableID forIndexPath:indexPath];
        if (customCell && [customCell isKindOfClass:[MCDayCell class]]) {
            customCell.day = day;
            customCell.model = self.model;
            [customCell reloadData];
            return customCell;;
        }
    }
    
    MCDayCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:MC_ID_HORIZONTAL_CELL forIndexPath:indexPath];
    cell.model = self.model;
    cell.day = day;
    [self updateDayCell:cell atIndexPath:indexPath];
    [cell reloadData];
    return cell;
}

- (void)updateDayCell:(MCDayCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if (self.model.handleStyle == MCalendarHandleStyleSingle) {
        if (self.startIndexPath && self.startIndexPath() && self.startIndexPath().section == self.section && self.startIndexPath().row == indexPath.row) {
            cell.day.handleState = MCDayHandleStateSelected;
        } else {
            cell.day.handleState = MCDayHandleStateDefault;
        }
    } else if (self.model.handleStyle == MCalendarHandleStyleDouble) {
        if (self.startIndexPath && self.startIndexPath() && [self indexPath:indexPath equalToIndexPath:self.startIndexPath()]) {
            if (self.endIndexPath()) {
                cell.day.handleState = MCDayHandleStateStarted;
            } else {
                cell.day.handleState = MCDayHandleStateSelected;
            }
        }else if (self.endIndexPath && self.endIndexPath() && [self indexPath:indexPath equalToIndexPath:self.endIndexPath()]) {
            if (self.endIndexPath() == self.startIndexPath()) {
                cell.day.handleState = MCDayHandleStateStartAndEnd;
            } else {
                cell.day.handleState = MCDayHandleStateEnded;
            }
        } else {
            NSIndexPath *indexPathInCalendar = [NSIndexPath indexPathForRow:indexPath.row inSection:self.section];
            if ([self.containedIndexPaths() containsObject:indexPathInCalendar]) {
                cell.day.handleState = MCDayHandleStateContained;
            } else {
                cell.day.handleState = MCDayHandleStateDefault;
            }
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self fixCollectionSizeForItemAtIndexPath:indexPath];
}

#pragma mark - 日历点击事件处理

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    MCDayCell * cell = (MCDayCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (cell.day.state != MCDayHandleStateInvalid) {
        // 单选
        if (self.model.handleStyle == MCalendarHandleStyleSingle) {
            [self singleStyleSelectItemAtIndexPath:indexPath];
        }
        // 双选
        else if(self.model.handleStyle == MCalendarHandleStyleDouble) {
            [self doubleStyleSelectItemAtIndexPath:indexPath];
        }
    }
}

- (void)singleStyleSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.MCHorizontalCellCanTouchBlock && !self .MCHorizontalCellCanTouchBlock(indexPath)) {
        return;
    }
    
    // 清空之前选中
    for (MCDayCell * cell in self.collectionView.visibleCells) {
        cell.day.handleState = MCDayHandleStateDefault;
        [cell reloadData];
    }
    
    self.modifyStartIndexPath(indexPath);
        
    MCDayCell * cell = (MCDayCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    cell.day.handleState = MCDayHandleStateSelected;
    [cell reloadData];

    [self completeCalendarByStyle:MCalendarHandleStyleSingle];
}

- (void)doubleStyleSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 代理配置当前点击是Start 还是 End
    MCDayHandleState state = MCDayHandleStateStarted;
    
    if (!self.startIndexPath() || [self indexPath:self.startIndexPath() laterThanIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:self.section]] || (self.startIndexPath() && self.endIndexPath())) {
        state = MCDayHandleStateStarted;
    } else {
        state = MCDayHandleStateEnded;
    }
    
    if (state == MCDayHandleStateStarted) {
        // 清空之前选中
        for (MCDayCell * cell in self.collectionView.visibleCells) {
            if (cell.day.state != MCDayHandleStateInvalid) {
                cell.day.handleState = MCDayHandleStateDefault;
            }
            [cell reloadData];
        }
        
        self.modifyStartIndexPath(nil);
        self.modifyEndIndexPath(nil);
        
        self.modifyStartIndexPath(indexPath);
        [self refreshCellAtIndexPath:indexPath state:MCDayHandleStateSelected];
    }
    else if (state == MCDayHandleStateEnded) {
        self.modifyEndIndexPath(indexPath);
        [self refreshCellAtIndexPath:indexPath state:MCDayHandleStateSelected];
    }
    
    if (self.startIndexPath() && self.endIndexPath()) {
        if (self.containedIndexPaths) {
            for (NSIndexPath *path in self.containedIndexPaths()) {
                if (path.section == self.section) {
                    [self refreshCellAtIndexPath:[NSIndexPath indexPathForRow:path.row inSection:0] state:MCDayHandleStateContained];
                }
            }
        }

        if (self.startIndexPath() == self.endIndexPath()) {
            [self refreshCellAtIndexPath:[NSIndexPath indexPathForRow:self.startIndexPath().row inSection:0] state:MCDayHandleStateStartAndEnd];
        }
        else {
            if (self.section == self.startIndexPath().section) {
                [self refreshCellAtIndexPath:[NSIndexPath indexPathForRow:self.startIndexPath().row inSection:0] state:MCDayHandleStateStarted];
            }
            if (self.section == self.endIndexPath().section) {
                [self refreshCellAtIndexPath:[NSIndexPath indexPathForRow:self.endIndexPath().row inSection:0] state:MCDayHandleStateEnded];
            }
        }
        
        [self completeCalendarByStyle:MCalendarHandleStyleDouble];
    }
}

// 日历选择完成
- (void)completeCalendarByStyle:(MCalendarHandleStyle)style
{
    if (self.MCHorizontalCellTouchBlock) {
        self.MCHorizontalCellTouchBlock();
    }
}

// 处理IndexPath对应Cell改变
- (void)refreshCellAtIndexPath:(NSIndexPath *)indexPath state:(MCDayHandleState)state
{
    MCDayCell * cell = (MCDayCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    cell.day.handleState = state;
    [cell reloadData];
}

#pragma mark - NSIndexPath相关算法

- (BOOL)indexPath:(NSIndexPath *)indexPath equalToIndexPath:(NSIndexPath *)comparedIndexPath
{
    BOOL result = NO;
    
    if (comparedIndexPath.section == self.section) {
        if (comparedIndexPath.row == indexPath.row) {
            result = YES;
        }
    }
    
    return result;
}

- (BOOL)indexPath:(NSIndexPath *)indexPath laterThanIndexPath:(NSIndexPath *)comparedIndexPath
{
    BOOL result = YES;
    
    if (indexPath.section > comparedIndexPath.section) {
        result = YES;
    }
    else if(indexPath.section < comparedIndexPath.section) {
        result = NO;
    }
    else if(indexPath.section == comparedIndexPath.section) {
        if (indexPath.row > comparedIndexPath.row) {
            result = YES;
        } else {
            result = NO;
        }
    }
    
    return result;
}

- (CGSize)fixCollectionSizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemWidth = 0.0f;
    if (indexPath.row % 7 > 0) {
        itemWidth = self.itemWidth;
    } else {
        itemWidth = self.collectionView.frame.size.width - self.itemWidth * 6;
    }
    
    return CGSizeMake(itemWidth, itemWidth);
}

@end
