//
//  WaterFlowLayout.h
//  WaterfallFlow
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterFlowLayout;
@protocol WaterFlowLayoutDelegate <NSObject>

@required
- (CGFloat)waterflowLayout:(WaterFlowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInWaterflowLayout:(WaterFlowLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(WaterFlowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(WaterFlowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(WaterFlowLayout *)waterflowLayout;

@end
@interface WaterFlowLayout : UICollectionViewLayout
/**代理对象*/
@property (nonatomic,weak) id<WaterFlowLayoutDelegate>delegate;
@end
