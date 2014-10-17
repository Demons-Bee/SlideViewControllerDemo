//
//  DHTabBarViewController.m
//  DHTabBarMenuViewPager
//
//  Created by 胡大函 on 14/10/8.
//  Copyright (c) 2014年 HuDahan_payMoreGainMore. All rights reserved.
//

#import "DHTabBarViewController.h"
#import "DHMenuPagerViewController.h"
#import "ViewController.h"

@interface DHTabBarViewController () {
    NSArray *_titles;
    NSArray *_images;
    NSArray *_selectedImages;
    UIImage *_backgroundImage;
    UIImage *_selectionIndicatorImage;
}

@end

@implementation DHTabBarViewController

- (id)initWithChildViewControllers:(NSArray *)controllers tabTitles:(NSArray *)titles tabImages:(NSArray *)images selectedImages:(NSArray *)selectedImages backgroundImage:(NSString *)backgroundImage selectionIndicatorImage:(NSString *)selectionIndicatorImage {
    if (self = [super init]) {
        for (int i = 0; i < controllers.count; ++i) {
            [self addChildViewController:controllers[i]];
            _titles = titles;
            _images = images;
            _selectedImages = selectedImages;
            _backgroundImage = [self imageNamedWithDefaultRenderingMode:backgroundImage];
            _selectionIndicatorImage = [self imageNamedWithDefaultRenderingMode:selectionIndicatorImage];
        }
        self.title = titles[0];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tabBar.backgroundImage = _backgroundImage;
    self.tabBar.selectionIndicatorImage = _selectionIndicatorImage;
    for (int i = 0; i < self.tabBar.items.count; i++) {
        UITabBarItem *item = self.tabBar.items[i];
        item.titlePositionAdjustment = UIOffsetMake(0, -3);
        item.title = _titles[i];
        item.image = [self imageNamedWithDefaultRenderingMode:_images[i]];
        item.selectedImage = [self imageNamedWithDefaultRenderingMode:_selectedImages[i]];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0x3c / 255.0 green:0x80 / 255.0 blue:0x1a / 255.0 alpha:1.0], NSBackgroundColorAttributeName, nil] forState:UIControlStateNormal];
    }
}

- (UIImage *)imageNamedWithDefaultRenderingMode:(NSString *)imageName {
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
}

@end
