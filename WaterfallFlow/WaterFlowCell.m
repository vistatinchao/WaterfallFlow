//
//  WaterFlowCell.m
//  WaterfallFlow
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "WaterFlowCell.h"
#import "ShopModel.h"
#import <UIImageView+WebCache.h>
@interface WaterFlowCell()
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;

@property (weak, nonatomic) IBOutlet UILabel *shopPriceLabel;

@end
@implementation WaterFlowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.shopPriceLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    // Initialization code
}

- (void)setShop:(ShopModel *)shop{
    _shop = shop;
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:shop.image] placeholderImage:[UIImage imageNamed:@"loading"]];
    self.shopPriceLabel.text = shop.price;
}

@end
