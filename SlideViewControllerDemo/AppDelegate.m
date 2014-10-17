//
//  AppDelegate.m
//  SlideTest
//
//  Created by 胡大函 on 14/10/10.
//  Copyright (c) 2014年 HuDahan_payMoreGainMore. All rights reserved.
//

#import "AppDelegate.h"
#import "NavOneController.h"
#import "NavTwoController.h"
#import "NavThreeController.h"
#import "DHTabBarViewController.h"
#import "DHMenuPagerViewController.h"
#import "ViewController.h"
#import "DHSlideMenuController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    ViewController *viewd = [[ViewController alloc] init];
    ViewController *viewd1 = [[ViewController alloc] init];
    ViewController *viewd2 = [[ViewController alloc] init];
    DHMenuPagerViewController *pagerView = [[DHMenuPagerViewController alloc] initWithViewControllers:@[viewd,viewd1,viewd2,viewd1,viewd2,viewd1,viewd2] titles:@[@"page1",@"page2",@"page3",@"page4",@"page5",@"page6",@"page7"] menuBackgroundColor:[UIColor colorWithRed:132%255/255.0 green:142%255/255.0 blue:192%255/255.0 alpha:1] titleColor:[UIColor colorWithRed:1. green:0. blue:0. alpha:0.3] titleColorHighlighted:[UIColor yellowColor]];
    pagerView.title = @"PagerView";
    
    NavOneController *one = [[NavOneController alloc] init];
    NavTwoController *two = [[NavTwoController alloc] initWithRootViewController:pagerView];
    NavThreeController *three = [[NavThreeController alloc] init];
    
    DHTabBarViewController *rootTab = [[DHTabBarViewController alloc] initWithChildViewControllers:@[two,one,three] tabTitles:@[@"PagerView",@"two",@"three"] tabImages:@[@"tabbar_discover",@"tabbar_discover",@"tabbar_discover"] selectedImages:@[@"tabbar_discover_highlighted",@"tabbar_discover_highlighted",@"tabbar_discover_highlighted"] backgroundImage:@"tab_bg" selectionIndicatorImage:@"tab_bg_pressed"];
    rootTab.tabBar.translucent = NO;
    
    UIViewController *leftViewController=[[UIViewController alloc]init];
    leftViewController.view.backgroundColor=[UIColor purpleColor];
    UIViewController *rightViewController=[[UIViewController alloc]init];
    rightViewController.view.backgroundColor=[UIColor cyanColor];
    
    //DHSlideMenuController *mainVC = [[DHSlideMenuController alloc] initWithMainViewController:rootTab leftViewController:leftViewController rightViewController:rightViewController animationBlock:nil];
    
    DHSlideMenuController *mainVC = [DHSlideMenuController sharedInstance];
    mainVC.mainViewController = rootTab;
    mainVC.leftViewController = leftViewController;
    mainVC.rightViewController = rightViewController;
    
    mainVC.animationType = SlideAnimationTypeMove;
    mainVC.needPanFromViewBounds = YES;
    _window.rootViewController = mainVC;
    [_window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
