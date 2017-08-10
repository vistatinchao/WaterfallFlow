//
//  WaterFallFlowView.m
//  WaterfallFlow
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "WaterFallFlowView.h"
#import "WaterFlowLayout.h"
#import "WaterFlowCell.h"
#import "ShopModel.h"

static NSString *const shopCell = @"shop";

@interface WaterFallFlowView()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WaterFlowLayoutDelegate>
/**collectionview*/
@property (nonatomic,weak) UICollectionView *collectionView;
/**数据源*/
@property (nonatomic,strong) NSMutableArray *shops;

@end
@implementation WaterFallFlowView

+ (instancetype)waterFlowView{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupCollectionView];
    }
    return self;
}

#pragma mark - 设置collectionview
- (void)setupCollectionView{
    WaterFlowLayout *layout = [[WaterFlowLayout alloc]init];
   // UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    layout.delegate = self;
    [self addSubview:collectionView];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WaterFlowCell class]) bundle:nil] forCellWithReuseIdentifier:shopCell];
    self.collectionView = collectionView;
    [self.collectionView reloadData];
}

#pragma mark - collectionviewDatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.shops.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WaterFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:shopCell forIndexPath:indexPath];
    cell.shop = self.shops[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%zd",indexPath.item);
}

#pragma mark - waterflowLayoutDelegate
- (CGFloat)waterflowLayout:(WaterFlowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth{
    ShopModel *shop = self.shops[index];
    return (itemWidth*shop.shopH)/shop.shopW;
}

- (CGFloat)columnCountInWaterflowLayout:(WaterFlowLayout *)waterflowLayout{
    return 4;
}

- (CGFloat)columnMarginInWaterflowLayout:(WaterFlowLayout *)waterflowLayout{
    return 20;
}
- (CGFloat)rowMarginInWaterflowLayout:(WaterFlowLayout *)waterflowLayout{
    return 20;
}
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(WaterFlowLayout *)waterflowLayout{
    return UIEdgeInsetsMake(40, 40, 40, 40);
}

#pragma mark - 数据lazy
- (NSMutableArray *)shops{
    if (!_shops) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"1.plist" ofType:nil];
        NSArray *shopsArr = [NSArray arrayWithContentsOfFile:path];
        _shops = [NSMutableArray array];
        for (NSDictionary *dict in shopsArr) {
            ShopModel *shop = [ShopModel shopWithDict:dict];
            [_shops addObject:shop];
        }
    }
    return _shops;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

@end
