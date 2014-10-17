//
//  DHLandscapeMenuScrollView.m
//  DHMenuViewPager
//
//  Created by 胡大函 on 14/9/30.
//  Copyright (c) 2014年 HuDahan_payMoreGainMore. All rights reserved.
//

#import "DHLandscapeMenuScrollView.h"
#define kButtonHeight 30
#define kIndicatorViewHeight 2
#define kButtonTagStarted 100
static float kMarginWidth = 15;
@implementation DHLandscapeMenuScrollView {
    UIView *indicatorView;
}

- (id)initWithFrame:(CGRect)frame Titles:(NSArray *)titles shouldShowIndicatorView:(BOOL)shouldShowIndicatorView {
    return [self initWithFrame:frame Titles:titles shouldShowIndicatorView:shouldShowIndicatorView menuBackgroundColor:nil titleColor:nil titleColorHighlighted:nil];
}

- (id)initWithFrame:(CGRect)frame Titles:(NSArray *)titles shouldShowIndicatorView:(BOOL)shouldShowIndicatorView menuBackgroundColor:(UIColor *)backColor titleColor:(UIColor *)normalColor titleColorHighlighted:(UIColor *)highlightedColor {
    int x = kMarginWidth;
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = backColor ? backColor : [UIColor whiteColor];
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        for (int i = 0; i < titles.count; ++i) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(x, 0, 0, kButtonHeight)];
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            [btn setTitleColor:normalColor ? normalColor : [UIColor lightGrayColor] forState:UIControlStateNormal];
            [btn setTitleColor:highlightedColor ? highlightedColor : [UIColor blueColor] forState:UIControlStateSelected];
            btn.tag = kButtonTagStarted + i;
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            [btn sizeToFit];
            [self addSubview:btn];
            x += btn.frame.size.width + kMarginWidth;
            if (i == 0) {
                [btn setSelected:YES];
            }
        }
        if (x <= self.frame.size.width) {
            [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
            x = 0;
            for (int i = 0; i < titles.count; ++i) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn setFrame:CGRectMake(x, 0, self.frame.size.width/titles.count, kButtonHeight)];
                [btn setTitle:titles[i] forState:UIControlStateNormal];
                [btn setTitleColor:normalColor ? normalColor : [UIColor lightGrayColor] forState:UIControlStateNormal];
                [btn setTitleColor:highlightedColor ? highlightedColor : [UIColor blueColor] forState:UIControlStateSelected];
                btn.tag = kButtonTagStarted + i;
                [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn];
                x += btn.frame.size.width;
                if (i == 0) {
                    [btn setSelected:YES];
                }
            }
        }
        if (shouldShowIndicatorView) {
            indicatorView = [[UIView alloc] initWithFrame:CGRectMake([self viewWithTag:kButtonTagStarted + 0].frame.origin.x, self.frame.size.height - kIndicatorViewHeight, [self viewWithTag:kButtonTagStarted + 0].frame.size.width, kIndicatorViewHeight)];
            [indicatorView setBackgroundColor:[UIColor redColor]];
            [self addSubview:indicatorView];
        }
        self.contentSize = CGSizeMake(x, self.frame.size.height);
        self.scrollsToTop = NO;
    }
    return self;
}

- (void)changeIndicatorViewWithPage:(CGFloat)page offset:(CGFloat)x {
    UIButton *button = (UIButton *)[self viewWithTag:page + kButtonTagStarted];
    indicatorView.frame = CGRectMake(button.frame.origin.x, indicatorView.frame.origin.y, button.frame.size.width, indicatorView.frame.size.height);
}

- (void)selectBtnWithTag:(NSUInteger)tag {
    UIButton *button = (UIButton *)[self viewWithTag:tag + kButtonTagStarted];
    [button setSelected:YES];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rc = CGRectMake(button.frame.origin.x - 20, button.frame.origin.y, button.frame.size.width + 100, button.frame.size.height);
        [self scrollRectToVisible:rc animated:NO];
        for (UIButton *btn in self.subviews) {
            if (![btn isEqual:button]) {
                if ([btn respondsToSelector:@selector(setSelected:)]) {
                    [btn setSelected:NO];
                }
            }
        }
    }];
}

- (void)clickBtn:(UIButton *)sender {
    [sender setSelected:YES];
    [UIView animateWithDuration:0.3 animations:^{
        [indicatorView setFrame:CGRectMake(sender.frame.origin.x, indicatorView.frame.origin.y, sender.frame.size.width, indicatorView.frame.size.height)];
        CGRect rc = CGRectMake(sender.frame.origin.x - 20, sender.frame.origin.y, sender.frame.size.width + 100, sender.frame.size.height);
        [self scrollRectToVisible:rc animated:NO];
        for (UIButton *btn in self.subviews) {
            if (![btn isEqual:sender]) {
                if ([btn respondsToSelector:@selector(setSelected:)]) {
                    [btn setSelected:NO];
                }
            }
        }
        if (_clickDelegate) {
            [_clickDelegate menuSelectedBtnIndex:sender.tag - kButtonTagStarted];
        }
    }];
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    return YES;
}

@end
