//
//  DHLandscapeTableView.m
//  DHMenuViewPager
//
//  Created by 胡大函 on 14/9/29.
//  Copyright (c) 2014年 HuDahan_payMoreGainMore. All rights reserved.
//

#import "DHLandscapeTableView.h"
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
@implementation DHLandscapeTableView

- (id)initWithFrame:(CGRect)frame viewArray:(NSArray *)views {
    if (self = [super initWithFrame:frame]) {
        //self.backgroundColor = [UIColor redColor];
        _tableView = [[UITableView alloc]initWithFrame:self.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollsToTop = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.transform = CGAffineTransformMakeRotation(-M_PI/2);
        _tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.pagingEnabled = YES;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.bounces =NO;
        [self addSubview:_tableView];
        _sourceArray = views;
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.frame.size.width;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"ViewCell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    cell.contentView.backgroundColor=[UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.transform = CGAffineTransformMakeRotation(M_PI/2);
    UIViewController *vc = [_sourceArray objectAtIndex:[indexPath row]];
    vc.view.frame = cell.bounds;
    [cell.contentView addSubview:vc.view];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_swipDelegate) {
        [_swipDelegate contentViewChangedIndex:[(_tableView.indexPathsForVisibleRows[0]) row]];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_swipDelegate) {
        [_swipDelegate contentViewChangedAtIndex:[(_tableView.indexPathsForVisibleRows[0]) row] offset:scrollView.contentOffset];
    }
}

@end
