//
//  DHLandscapeTableView.h
//  DHMenuViewPager
//
//  Created by 胡大函 on 14/9/29.
//  Copyright (c) 2014年 HuDahan_payMoreGainMore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHLandscapeMenuScrollView.h"
@interface DHLandscapeTableView : UIView <UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *sourceArray;
@property (assign, nonatomic) id<MenuViewDelegate> swipDelegate;

- (id)initWithFrame:(CGRect)frame viewArray:(NSArray *)views;

@end
