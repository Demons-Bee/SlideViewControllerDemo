//
//  DHTabBarViewController.h
//  DHTabBarMenuViewPager
//
//  Created by 胡大函 on 14/10/8.
//  Copyright (c) 2014年 HuDahan_payMoreGainMore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHTabBarViewController : UITabBarController

@property (strong, nonatomic) NSArray *tabBarImages;

- (id)initWithChildViewControllers:(NSArray *)controllers tabTitles:(NSArray *)titles tabImages:(NSArray *)images selectedImages:(NSArray *)selectedImages backgroundImage:(NSString *)backgroundImage selectionIndicatorImage:(NSString *)selectionIndicatorImage;

@end
