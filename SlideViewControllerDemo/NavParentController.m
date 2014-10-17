

//
//  NavParentController.m
//  SlideTest
//
//  Created by 胡大函 on 14/10/11.
//  Copyright (c) 2014年 HuDahan_payMoreGainMore. All rights reserved.
//

#import "NavParentController.h"
#import "DHSlideMenuController.h"
@interface NavParentController ()

@end

@implementation NavParentController

- (void)loadView {
    [super loadView];
    self.navigationBar.translucent = NO;
    //self.navigationBar.barTintColor = [UIColor colorWithRed:132%255/255.0 green:142%255/255.0 blue:192%255/255.0 alpha:0.8];
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor cyanColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:30],NSFontAttributeName, nil];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    for (UIViewController *vc in self.childViewControllers) {
        vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ToggleMenu"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleSideView)];
        vc.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    }
    [super viewDidAppear:animated];
}

- (void)toggleSideView {
    [[DHSlideMenuController sharedInstance] showLeftViewController:YES];
}

@end
