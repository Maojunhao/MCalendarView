//
//  MCHorizontalView.m
//  MCalendarView
//
//  Created by Maojunhao on 2020/4/21.
//  Copyright © 2020 Maojunhao. All rights reserved.
//

#import "MCHorizontalView.h"
#import "MCHorizontalCell.h"
#import "MCDataModel.h"

static NSString * const MC_ID_HORIZONTAL_MONTH_CELL = @"MC_ID_HORIZONTAL_MONTH_CELL";

@interface MCHorizontalView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

// 状态改变IndexPath
@property (nonatomic, strong) NSIndexPath * startIndexPath;

@property (nonatomic, strong) NSIndexPath * endIndexPath;

@property (nonatomic, strong) NSArray <NSIndexPath *> * containedIndexPaths;

@property (nonatomic, strong) UICollectionView * collectionView;

// 滑动时，固定的一个IndexPath
@property (nonatomic, strong) NSIndexPath * fixedIndexPath;

// 第一个可用的日期
@property (nonatomic, strong) NSIndexPath * firstValidIndexPath;

@end

@implementation MCHorizontalView

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
    [self setupCollectionView];
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
    [self reloadSelectedIndexPath];
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

- (void)reloadSelectedIndexPath
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.model.handleStyle == MCalendarHandleStyleDouble)
        {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.startIndexPath.section inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        }
        else if (self.model.handleStyle == MCalendarHandleStyleSingle)
        {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.startIndexPath.section inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        }
    });
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.collectionView.frame = self.bounds;
}

- (void)defaultSelectedAtStartIndexPath:(NSIndexPath *)startIndexPath endIndexPath:(NSIndexPath *)endIndexPath
{
    if (self.model.handleStyle == MCalendarHandleStyleSingle)
    {
        self.startIndexPath = startIndexPath;
    }
    else if (self.model.handleStyle == MCalendarHandleStyleDouble)
    {
        self.startIndexPath = startIndexPath;
        self.endIndexPath = endIndexPath;
        self.containedIndexPaths = [self indexPathsBetweenStartIndexPath:self.startIndexPath endIndexPath:self.endIndexPath];
    }
}

- (void)setPage:(NSInteger)page
{
    CGFloat offset = self.collectionView.frame.size.width * page;
    offset = offset > 0 ? offset : 0;
    offset = offset < self.collectionView.contentSize.width ? offset : self.collectionView.contentSize.width;
    [self.collectionView setContentOffset:CGPointMake(offset, 0) animated:YES];
}

#pragma mark - CollectionView

- (void)setupCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing      = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate   = self;
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self.collectionView registerClass:[MCHorizontalCell class] forCellWithReuseIdentifier:MC_ID_HORIZONTAL_MONTH_CELL];
    
    [self addSubview:self.collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MCHorizontalCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:MC_ID_HORIZONTAL_MONTH_CELL forIndexPath:indexPath];
    MCMonthModel * month = [self.datas objectAtIndex:indexPath.row];
    cell.section = indexPath.row;
    cell.month = month;
    cell.model = self.model;
    [self configBlockForCell:cell];
    [cell reloadData];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.bounds.size.width, (collectionView.bounds.size.width / 7.0f) * 6 + self.model.monthHeaderHeight);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    MCHorizontalCell * monthCell = (MCHorizontalCell *)cell;
    [monthCell reloadData];
}

- (void)configBlockForCell:(MCHorizontalCell *)cell
{
    __weak typeof(self) weakSelf = self;
    __weak typeof(cell) weakCell = cell;

    if (!cell.modifyStartIndexPath) {
        cell.modifyStartIndexPath = ^(NSIndexPath * _Nonnull indexPath) {
            if (indexPath) {
                weakSelf.startIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:weakCell.section];
            } else {
                weakSelf.endIndexPath = nil;
            }
        };
    }

    if (!cell.modifyEndIndexPath) {
        cell.modifyEndIndexPath = ^(NSIndexPath * _Nonnull indexPath) {
            if (indexPath) {
                weakSelf.endIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:weakCell.section];
            } else {
                weakSelf.endIndexPath = nil;
            }
        };
    }

    if (!cell.startIndexPath) {
        cell.startIndexPath = ^NSIndexPath * _Nonnull {
            return weakSelf.startIndexPath;
        };
    }
    if (!cell.endIndexPath) {
        cell.endIndexPath = ^NSIndexPath * _Nonnull {
            return weakSelf.endIndexPath;
        };
    }

    if (!cell.containedIndexPaths) {
        cell.containedIndexPaths = ^NSArray<NSIndexPath *> * _Nonnull {
            return [weakSelf indexPathsBetweenStartIndexPath:weakSelf.startIndexPath endIndexPath:weakSelf.endIndexPath];
        };
    }

    /** 完成操作 **/
    if (!cell.MCHorizontalCellCanTouchBlock) {
        cell.MCHorizontalCellCanTouchBlock = ^BOOL(NSIndexPath * _Nonnull indexPath) {
            if (weakSelf.MCHorizontalViewCanTouchBlock) {
                MCDayModel * day = [weakSelf getCalendarDayByIndexPath:self.startIndexPath];
                return weakSelf.MCHorizontalViewCanTouchBlock(weakSelf.model.handleStyle, day);
            }
            return YES;
        };
    }
    
    if (!cell.MCHorizontalCellTouchBlock) {
        cell.MCHorizontalCellTouchBlock = ^{
            if (weakSelf.MCHorizontalViewTouchBlock) {
                MCDayModel * startDay = [weakSelf getCalendarDayByIndexPath:self.startIndexPath];
                MCDayModel * endDay = [weakSelf getCalendarDayByIndexPath:self.endIndexPath];
                weakSelf.MCHorizontalViewTouchBlock(weakSelf.model.handleStyle, startDay, endDay);
            }
        };
    }
}

- (MCDayModel *)getCalendarDayByIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < self.datas.count)
    {
        MCMonthModel *month = self.datas[indexPath.section];
        
        if (indexPath.row < month.days.count)
        {
            MCDayModel *day = [month.days objectAtIndex:indexPath.row];
            return day;
        }
    }
    return nil;
}

#pragma mark - NSIndexPath

- (NSArray <NSIndexPath *> *)indexPathsBetweenStartIndexPath:(NSIndexPath *)startIndexPath endIndexPath:(NSIndexPath *)endIndexPath
{
    NSMutableArray *indexPaths = [NSMutableArray array];
    
    for (NSInteger section = startIndexPath.section; section <= endIndexPath.section; section++) {
        
        MCMonthModel *month = self.datas[section];
        
        
        NSInteger startRow = 0;
        NSInteger endRow = month.days.count;
        
        if (section == startIndexPath.section) {
            startRow = startIndexPath.row + 1;
        }
        
        if (section == endIndexPath.section) {
            endRow = endIndexPath.row;
        }
        
        
        for (NSInteger row = startRow; row < endRow; row ++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            [indexPaths addObject:indexPath];
        }
    }
    
    return indexPaths;
}

@end
