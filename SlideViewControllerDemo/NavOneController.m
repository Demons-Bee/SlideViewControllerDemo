//
//  NavOneController.m
//  SlideTest
//
//  Created by 胡大函 on 14/10/10.
//  Copyright (c) 2014年 HuDahan_payMoreGainMore. All rights reserved.
//

#import "NavOneController.h"
#import "DHSlideMenuController.h"
@interface NavOneController ()

@end

@implementation NavOneController

- (void)loadView {
    [super loadView];
    UIViewController *root = [[UIViewController alloc] init];
    root.view.backgroundColor = [UIColor brownColor];
    root.title = @"SingleView";
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 242, self.view.frame.size.width - 60, 100)];
    lable1.text = @"Lable";
    lable1.textColor = [UIColor whiteColor];
    lable1.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:50];
    lable1.textAlignment = NSTextAlignmentCenter;
    lable1.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.7];
    [root.view addSubview:lable1];
    [self addChildViewController:root];
}

@end
