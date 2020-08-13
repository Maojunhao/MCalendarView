//
//  MCVerticalView.m
//  MCalendarView
//
//  Created by Maojunhao on 2020/4/21.
//  Copyright © 2020 Maojunhao. All rights reserved.
//

#import "MCVerticalView.h"
#import "MCDayCell.h"
#import "MCMonthHeaderView.h"

#import "MCDataModel.h"

static NSString * const MC_ID_CELL = @"MC_VERTICAL_CELL_DAY";
static NSString * const MC_ID_HEADER = @"MC_VERTICAL_HEADER_MONTH";

@interface MCVerticalView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *        collectionView;

@property (nonatomic, assign) CGFloat                   itemWidth;

@property (nonatomic, assign) BOOL                      renderCompleted;

// 状态改变IndexPath
@property (nonatomic, strong) NSIndexPath *             startIndexPath;
@property (nonatomic, strong) NSIndexPath *             endIndexPath;
@property (nonatomic, strong) NSArray <NSIndexPath *> * containedIndexPaths;

// 滑动时，固定的一个IndexPath
@property (nonatomic, strong) NSIndexPath *             fixedIndexPath;
// 第一个可用的日期
@property (nonatomic, strong) NSIndexPath *             firstValidIndexPath;

@end

@implementation MCVerticalView

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
            [self.collectionView scrollToItemAtIndexPath:self.startIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
        }
        else if (self.model.handleStyle == MCalendarHandleStyleSingle)
        {
            [self.collectionView scrollToItemAtIndexPath:self.startIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
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
//        self.containedIndexPaths = [self indexPathsBetweenStartIndexPath:self.startIndexPath endIndexPath:self.endIndexPath];
    }
}

#pragma mark - CollectionView

- (void)setupCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setHeaderReferenceSize:CGSizeMake(self.frame.size.width, 100)];
    flowLayout.sectionHeadersPinToVisibleBounds = YES;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing      = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self.collectionView registerClass:[MCDayCell class] forCellWithReuseIdentifier:MC_ID_CELL];
    [self.collectionView registerClass:[MCMonthHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MC_ID_HEADER];
    
    [self addSubview:self.collectionView];
    
    [self configCollectionItemWidth];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.bounds.size.width, self.model.monthHeaderHeight);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.datas.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    MCMonthModel * month = [self.datas objectAtIndex:section];
    return month.days.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        MCMonthModel * month = self.datas[indexPath.section];
        // 先检查自定义
        if (self.model.monthReusableID) {
            MCMonthHeaderView * customHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:self.model.monthReusableID forIndexPath:indexPath];
            if ([customHeaderView isKindOfClass:[MCMonthHeaderView class]]) {
                customHeaderView.model = self.model;
                customHeaderView.month = month;
                [customHeaderView reloadData];
                return customHeaderView;
            }
        }
        
        MCMonthHeaderView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:MC_ID_HEADER forIndexPath:indexPath];
        headerView.model = self.model;
        headerView.month = month;
        [headerView reloadData];
        return headerView;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MCMonthModel * month = [self.datas objectAtIndex:indexPath.section];
    MCDayModel * day     = [month.days objectAtIndex:indexPath.row];
    
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
        
    MCDayCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:MC_ID_CELL forIndexPath:indexPath];
    cell.day = day;
    cell.model = self.model;
    [cell reloadData];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self fixCollectionSizeForItemAtIndexPath:indexPath];

}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    MCDayCell *dayCell = (MCDayCell *)cell;

    if (self.model.handleStyle == MCalendarHandleStyleSingle)
    {
        dayCell.day.handleState = (indexPath == self.startIndexPath) ? MCDayHandleStateSelected : MCDayHandleStateDefault;
    }
    else if (self.model.handleStyle == MCalendarHandleStyleDouble)
    {
        if (indexPath == self.startIndexPath)
        {
            dayCell.day.handleState = (self.startIndexPath == self.endIndexPath) ? MCDayHandleStateStartAndEnd : MCDayHandleStateStarted;
        }
        else if (indexPath == self.endIndexPath)
        {
            dayCell.day.handleState = (self.startIndexPath == self.endIndexPath) ? MCDayHandleStateStartAndEnd : MCDayHandleStateEnded;
        }
        else{
            
            dayCell.day.handleState = ([self.containedIndexPaths containsObject:indexPath]) ? MCDayHandleStateContained : MCDayHandleStateDefault;
        }
    }
    
    [dayCell reloadData];
}


#pragma mark - 日历点击事件处理

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];

    // 自定义是否可选条件
    BOOL canTouch = YES;
    if (self.MCVerticalViewCanTouchBlock) {
        MCDayModel * day = [self getCalendarDayByIndexPath:indexPath];
        canTouch = self.MCVerticalViewCanTouchBlock(self.model.handleStyle, day);
    }
    if (!canTouch) { return; }
    
    // 默认点击选中规则
    MCDayCell * cell = (MCDayCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.day.state != MCDayStateInvalidday) {
        // 单选
        if (self.model.handleStyle == MCalendarHandleStyleSingle)
        {
            [self singleStyleSelectItemAtIndexPath:indexPath];
        }
        // 双选
        else if(self.model.handleStyle == MCalendarHandleStyleDouble)
        {
            [self doubleStyleSelectItemAtIndexPath:indexPath];
        }
    }
}

- (void)singleStyleSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 清空之前选中
    for (MCDayCell *cell in self.collectionView.visibleCells) {
        cell.day.handleState = MCDayHandleStateDefault;
        [cell reloadData];
    }

    [self refreshCellAtIndexPath:indexPath state:MCDayHandleStateSelected];
    self.startIndexPath = indexPath;

    [self completeCalendarByStyle:MCalendarHandleStyleSingle];
}

- (void)doubleStyleSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MCDayHandleState state = MCDayHandleStateStarted;

    if (!self.startIndexPath || [self indexPath:self.startIndexPath laterThanIndexPath:indexPath] || (self.startIndexPath && self.endIndexPath))
    {
        state = MCDayHandleStateStarted;
    }else
    {
        state = MCDayHandleStateEnded;
    }

    if (state == MCDayHandleStateStarted)
    {
        // 清空之前选中
        for (MCDayCell *cell in self.collectionView.visibleCells) {
            if (cell.day.handleState != MCDayHandleStateInvalid) {
                cell.day.handleState = MCDayHandleStateDefault;
            }
            [cell reloadData];
        }

        self.startIndexPath = nil;
        self.endIndexPath = nil;
        self.containedIndexPaths = nil;

        self.startIndexPath = indexPath;
        
        [self refreshCellAtIndexPath:self.startIndexPath state:MCDayHandleStateStarted];
    }
    else if (state == MCDayHandleStateEnded)
    {
        self.endIndexPath = indexPath;
        [self refreshCellAtIndexPath:indexPath state:MCDayHandleStateEnded];
    }

    if (self.startIndexPath && self.endIndexPath)
    {
        self.containedIndexPaths = [self indexPathsBetweenStartIndexPath:self.startIndexPath endIndexPath:self.endIndexPath];

        for (NSIndexPath *path in self.containedIndexPaths) {
            [self refreshCellAtIndexPath:path state:MCDayHandleStateContained];
        }

        if (self.startIndexPath == self.endIndexPath)
        {
            [self refreshCellAtIndexPath:self.startIndexPath state:MCDayHandleStateStartAndEnd];
        }
    }
    
    [self completeCalendarByStyle:MCalendarHandleStyleDouble];
}


// 处理IndexPath对应Cell改变
- (void)refreshCellAtIndexPath:(NSIndexPath *)indexPath state:(MCDayHandleState)handleState
{
    MCDayCell *cell = (MCDayCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    cell.day.handleState = handleState;
    [cell reloadData];
}

// 日历选择完成
- (void)completeCalendarByStyle:(MCalendarHandleStyle)handleStyle
{
    if (!self.MCVerticalViewTouchBlock) {  return; }
    
    MCDayModel *startDay = [self getCalendarDayByIndexPath:self.startIndexPath];
    MCDayModel *endDay = nil;
    
    if (handleStyle == MCalendarHandleStyleDouble && self.endIndexPath) {
        endDay = [self getCalendarDayByIndexPath:self.endIndexPath];
    }
    
    self.MCVerticalViewTouchBlock(self.model.handleStyle, startDay, endDay);

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

- (void)collectionViewAutoScroll
{
    CGPoint offset = self.collectionView.contentOffset;
    self.collectionView.contentOffset = CGPointMake(offset.x, offset.y+5);
}


#pragma mark - NSIndexPath相关算法

//- (NSIndexPath *)lastValidIndexPathToIndexPath:(NSIndexPath *)indexPath;
//{
//    NSIndexPath *destIndexPath;
//
//    // 当前IndexPath可用，直接返回
//    MCMonthModel *month = self.datas[indexPath.section];
//    MCDayModel *day = [month.days objectAtIndex:indexPath.row];
//
//    if (day.state != CECalendarDayStateEmpty && day.state != CECalendarDayStatePastday) {
//        return indexPath;
//    }
//
//    // 当前IndexPath不可用
//    if (indexPath.section == 0)
//    {
//        MCMonthModel * month = self.datas[indexPath.section];
//        for (int i = 0; i < month.days.count - 1; i++)
//        {
//            MCDayModel *day = [month.days objectAtIndex:month.days.count - 1 - i];
//            if (day.state != CECalendarDayStateEmpty && day.state != CECalendarDayStatePastday) {
//                destIndexPath = [NSIndexPath indexPathForRow:(month.days.count - 1 - i) inSection:(indexPath.section)];
//                break;
//            }
//        }
//    }
//    else
//    {
//        NSInteger section = indexPath.section - 1;
//        if (indexPath.row > 15) {
//            section = indexPath.section;
//        }
//
//        MCMonthModel * month = self.datas[section];
//        for (int i = 0; i < month.days.count - 1; i++)
//        {
//            MCDayModel *day = [month.days objectAtIndex:month.days.count - 1 - i];
//            if (day.state != CECalendarDayStateEmpty && day.state != CECalendarDayStatePastday) {
//                destIndexPath = [NSIndexPath indexPathForRow:(month.days.count - 1 - i) inSection:(section)];
//                break;
//            }
//        }
//    }
//
//    return destIndexPath;
//}
//
//- (NSIndexPath *)firstValidIndexPathInCollectionView
//{
//    NSInteger section = 0, row = 0;
//    BOOL complete = NO;
//
//    for (int i = 0; i < self.datas.count; i++)
//    {
//        if (complete == YES) {
//            break;
//        }
//        MCMonthModel *month = [self.datas objectAtIndex:i];
//
//        for (int j = 0; j < month.days.count; j ++)
//        {
//            MCDayModel *day = [month.days objectAtIndex:j];
//            if (day.state != CECalendarDayStatePastday) {
//                section = i;
//                row = j;
//                complete = YES;
//                break;
//            }
//        }
//    }
//
//    return [NSIndexPath indexPathForRow:row inSection:section];
//}
//
//- (NSIndexPath *)indexPathInCollectionView:(UICollectionView *)collectionView byPoint:(CGPoint)point
//{
//    NSInteger section = 0;
//    NSInteger row = 0;
//
//    CGFloat height = 0;
//
//    CGSize itemSize = CGSizeMake(self.collectionView.bounds.size.width / 7.0f, self.collectionView.bounds.size.width / 7.0f);
//
//    for (int i = 0; i < self.datas.count; i++)
//    {
//        MCMonthModel *month = [self.datas objectAtIndex:i];
//
//        NSInteger maxRow = month.days.count % 7 > 0 ? (month.days.count / 7 + 1) : (month.days.count / 7);
//
//        NSInteger tempHeight = height + self.option.modelHeaderHeight + itemSize.height * maxRow;
//
//        // 计算 section
//        if (point.y < tempHeight)
//        {
//            section = i;
//
//            // 计算 row , y = 当前section 减去header相对y坐标
//            CGFloat y = point.y - height - self.option.modelHeaderHeight;
//
//            NSInteger viewRow = y / itemSize.height;
//
//            NSInteger column = point.x / itemSize.width;
//
//            row = (viewRow * 7 + column) > 0 ? (viewRow * 7 + column) : 0;
//
//            break;
//        }
//
//        height = tempHeight;
//
//    }
//
//    return [NSIndexPath indexPathForRow:row inSection:section];
//}


- (NSArray <NSIndexPath *> *)indexPathsBetweenStartIndexPath:(NSIndexPath *)startIndexPath endIndexPath:(NSIndexPath *)endIndexPath
{
    NSMutableArray *indexPaths = [NSMutableArray array];

    for (NSInteger section = startIndexPath.section; section <= endIndexPath.section; section++) {

        MCMonthModel * month = [self.datas objectAtIndex:section];

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

- (BOOL)indexPath:(NSIndexPath *)indexPath laterThanIndexPath:(NSIndexPath *)comparedIndexPath
{
    BOOL result = YES;

    if (indexPath.section > comparedIndexPath.section)
    {
        result = YES;
    }
    else if(indexPath.section < comparedIndexPath.section)
    {
        result = NO;
    }
    else if(indexPath.section == comparedIndexPath.section)
    {
        if (indexPath.row > comparedIndexPath.row)
        {
            result = YES;
        }else{
            result = NO;
        }
    }

    return result;
}

#pragma mark - Tools

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

//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(UIFont *)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil];
    return rect.size.width;
}

- (CGSize)fixCollectionSizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemWidth = 0.0f;
    
    if (indexPath.row % 7 > 0)
    {
        itemWidth = self.itemWidth;
    }
    else
    {
        itemWidth = self.collectionView.frame.size.width - self.itemWidth * 6;
    }
    
    return CGSizeMake(itemWidth, itemWidth);
}



@end
 
