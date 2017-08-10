//
//  WaterFlowLayout.m
//  WaterfallFlow
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "WaterFlowLayout.h"
/**默认item之间的间距*/
static CGFloat const itemMargin = 10;
/**默认行间距*/
static CGFloat const itemLineMargin = 10;
/**默认最大列数*/
static CGFloat const maxColumn = 3;
/**默认行偏移量*/
static UIEdgeInsets const sectionInset = {10,10,10,10};

@interface WaterFlowLayout()
/**UICollectionViewLayoutAttributes*/
@property (nonatomic,strong) NSMutableArray *layoutAttributes;
/**存放每一列的高度*/
@property (nonatomic,strong) NSMutableArray *columnHeightArr;
/**内容的高度*/
@property (nonatomic,assign) CGFloat contentHeight;

/**返回最大列数*/
- (CGFloat)columnCount;
/**返回item之间的间距*/
- (CGFloat)itemMargin;
/**返回行间距*/
- (CGFloat)itemLineMargin;
/**返回行偏移量*/
- (UIEdgeInsets)sectionInset;

@end
@implementation WaterFlowLayout

#pragma mark - 初始化布局重写父类方法布局cell

- (void)prepareLayout{
    [super prepareLayout];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    [self.layoutAttributes removeAllObjects];
    for (NSInteger i=0; i<count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.layoutAttributes addObject:attribute];
    }

}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.layoutAttributes;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *layoutAttribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat cellX = 0;
    CGFloat cellY = 0;
    CGFloat cellW = 0;
    CGFloat cellH = 0;
    NSInteger targetIndex = 0;
    CGFloat minColumH = [self.columnHeightArr.firstObject floatValue];
    CGFloat count = self.columnHeightArr.count;
    for (NSInteger i=1; i<count; i++) {//找到最短那一列
        CGFloat columnH = [self.columnHeightArr[i] floatValue];
        if (minColumH>columnH) {
            minColumH = columnH;
            targetIndex = i;

        }
    }

    cellW = (self.collectionView.frame.size.width-self.sectionInset.left-self.sectionInset.right-(self.columnCount-1)*self.itemMargin)/self.columnCount;
    cellH = [self.delegate waterflowLayout:self heightForItemAtIndex:indexPath.item itemWidth:cellW];
    cellX = self.sectionInset.left+targetIndex*(cellW+self.itemMargin);
    cellY = minColumH+self.itemLineMargin;
    layoutAttribute.frame = CGRectMake(cellX, cellY, cellW, cellH);
    // 更新最短那一列高度
    self.columnHeightArr[targetIndex] = @(CGRectGetMaxY(layoutAttribute.frame));
    // 记录内容的高度
    CGFloat columnHeight = [self.columnHeightArr[targetIndex] doubleValue];
    if (self.contentHeight < columnHeight) {
        self.contentHeight = columnHeight;
    }
    return layoutAttribute;
}

#pragma mark - 返回内容高度
- (CGSize)collectionViewContentSize{
    return CGSizeMake(0, self.contentHeight+self.sectionInset.bottom);
}

#pragma mark - 返回代理数据
- (CGFloat)columnCount{
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterflowLayout:)]) {
        return [self.delegate columnCountInWaterflowLayout:self];
    }
    return maxColumn;
}

- (CGFloat)itemMargin{

    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterflowLayout:)]) {
        return  [self.delegate columnMarginInWaterflowLayout:self];
    }
    return itemMargin;
}
- (CGFloat)itemLineMargin{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterflowLayout:)]) {
        return  [self.delegate rowMarginInWaterflowLayout:self];
    }
    return itemLineMargin;
}
- (UIEdgeInsets)sectionInset{
    if([self.delegate respondsToSelector:@selector(edgeInsetsInWaterflowLayout:)]){
        return [self.delegate edgeInsetsInWaterflowLayout:self];
    }
    return sectionInset;
}

#pragma mark - lazy
- (NSMutableArray *)columnHeightArr{
    if (!_columnHeightArr) {
        _columnHeightArr = [NSMutableArray array];
        for (NSInteger i=0; i<self.columnCount; i++) {
            [_columnHeightArr addObject:@(10)];
        }
    }
    return _columnHeightArr;
}
- (NSMutableArray *)layoutAttributes{
    if (!_layoutAttributes) {
        _layoutAttributes = [NSMutableArray array];
    }
    return _layoutAttributes;
}


@end
