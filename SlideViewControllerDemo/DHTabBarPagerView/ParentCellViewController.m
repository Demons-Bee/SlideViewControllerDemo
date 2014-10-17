//
//  ParentCellViewController.m
//  DHTabBarMenuViewPager
//
//  Created by 胡大函 on 14/10/8.
//  Copyright (c) 2014年 HuDahan_payMoreGainMore. All rights reserved.
//

#import "ParentCellViewController.h"

@interface ParentCellViewController ()

@end

@implementation ParentCellViewController

- (void)loadView {
    [super loadView];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 49 - 30);
}

@end
