//
//  DHMenuPagerViewController.h
//  DHMenuViewPager
//
//  Created by 胡大函 on 14/9/30.
//  Copyright (c) 2014年 HuDahan_payMoreGainMore. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DHMenuPagerViewDelegate <NSObject>

- (void)changedTitle:(NSString *)title;

@end

@interface DHMenuPagerViewController : UIViewController

@property (assign, nonatomic) id<DHMenuPagerViewDelegate> delegate;

- (id)initWithViewControllers:(NSArray *)controllers;

- (id)initWithViewControllers:(NSArray *)controllers titles:(NSArray *)titles;

- (id)initWithViewControllers:(NSArray *)controllers titles:(NSArray *)titles menuBackgroundColor:(UIColor *)backColor titleColor:(UIColor *)normalColor titleColorHighlighted:(UIColor *)highlightedColor;

@end
