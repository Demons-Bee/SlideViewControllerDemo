//
//  ViewController.m
//  SlideTest
//
//  Created by 胡大函 on 14/10/10.
//  Copyright (c) 2014年 HuDahan_payMoreGainMore. All rights reserved.
//

#import "ViewController.h"
#import "DHMenuPagerViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    float a = rand() % 255 / 255.0;
    self.view.backgroundColor = [UIColor colorWithRed:132%255/255.0 green:142%255/255.0 blue:192%255/255.0 alpha:a];
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 60, 100)];
    lable1.text = @"Lable";
    lable1.center = self.view.center;
    lable1.textColor = [UIColor whiteColor];
    lable1.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:50];
    lable1.textAlignment = NSTextAlignmentCenter;
    lable1.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.7];
    [self.view addSubview:lable1];
}

@end
