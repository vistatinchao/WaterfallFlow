//
//  ShopModel.m
//  WaterfallFlow
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ShopModel.h"

@implementation ShopModel
+(instancetype)shopWithDict:(NSDictionary *)dict{
    ShopModel *shop = [[self alloc]init];
    shop.image = dict[@"img"];
    shop.price = dict[@"price"];
    shop.shopW = [dict[@"w"] floatValue];
    shop.shopH = [dict[@"h"] floatValue];
    return shop;
}
@end
