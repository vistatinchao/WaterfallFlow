//
//  ShopModel.h
//  WaterfallFlow
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopModel : NSObject
/**商品图片*/
@property (nonatomic,copy) NSString *image;
/**商品价格*/
@property (nonatomic,copy) NSString *price;
/**商品宽度*/
@property (nonatomic,assign) CGFloat shopW;
/**商品高度*/
@property (nonatomic,assign) CGFloat shopH;

+(instancetype)shopWithDict:(NSDictionary *)dict;
@end
