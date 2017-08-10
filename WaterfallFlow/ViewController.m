//
//  ViewController.m
//  WaterfallFlow
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ViewController.h"
#import "WaterFallFlowView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WaterFallFlowView *flowView = [WaterFallFlowView waterFlowView];
    [self.view addSubview:flowView];
    flowView.frame = self.view.bounds;
}




@end
