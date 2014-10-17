//
//  DHSlideMenuController.m
//  DHSlideMenuController
//
//  Created by 胡大函 on 14/10/11.
//  Copyright (c) 2014年 HuDahan_payMoreGainMore. All rights reserved.
//

#import "DHSlideMenuController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface DHSlideMenuController () <UIGestureRecognizerDelegate> {
    UIView *baseView;
    UIView *currentView;
    UIPanGestureRecognizer *panGestureRecognizer;
    CGPoint startPanPoint;
    BOOL panMovingLeftOrRight;
    UIButton *coverButton;
    BOOL isInited;
}

@end
static float canTouchAreaWidth = 40;
@implementation DHSlideMenuController

+ (instancetype)sharedInstance {
    static DHSlideMenuController *sharedSMC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSMC = [[self alloc] init];
    });
    return sharedSMC;
}

- (instancetype)init {
    return [self initWithNibName:nil bundle:nil];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _leftViewShowWidth=200;
        _rightViewShowWidth=200;
        _animationDuration = 0.35;
        _needShowBoundsShadow = YES;
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        panGestureRecognizer.delegate = self;
        panMovingLeftOrRight = NO;
        coverButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [coverButton addTarget:self action:@selector(hideSideViewController) forControlEvents:UIControlEventTouchUpInside];
        isInited = YES;
    }
    return self;
}

- (instancetype)initWithMainViewController:(UIViewController *)main leftViewController:(UIViewController *)left rightViewController:(UIViewController *)right animationBlock:(MainViewAnimationBlock)block {
    if (self = [self init]) {
        _mainViewController = main;
        _leftViewController = left;
        _rightViewController = right;
        _mainViewAnimationBlock = block;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    baseView = self.view;
    self.needSwipeShowMenu = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!_mainViewController) {
        NSAssert(NO, @"You must set mainViewController!!");
    }
    if (isInited) {
        [self resetCurrentViewToMainViewController];
        isInited = NO;
    }
}

- (void)setMainViewController:(UIViewController *)mainViewController {
    if (_mainViewController != mainViewController) {
        if (_mainViewController) {
            [_mainViewController removeFromParentViewController];
        }
        _mainViewController = mainViewController;
        if (_mainViewController) {
            [self addChildViewController:_mainViewController];
        }
        if (!isInited) {
            [self resetCurrentViewToMainViewController];
        }
    }
    
}

- (void)setLeftViewController:(UIViewController *)leftViewController {
    if (_leftViewController != leftViewController) {
        if (_leftViewController) {
            [_leftViewController removeFromParentViewController];
        }
        _leftViewController = leftViewController;
        if (_leftViewController) {
            [self addChildViewController:_leftViewController];
        }
    }
}

- (void)setRightViewController:(UIViewController *)rightViewController {
    if (_rightViewController != rightViewController) {
        if (_rightViewController) {
            [_rightViewController removeFromParentViewController];
        }
        _rightViewController = rightViewController;
        if (_rightViewController) {
            [self addChildViewController:_rightViewController];
        }
    }
}

- (void)setNeedSwipeShowMenu:(BOOL)needSwipeShowMenu {
    _needSwipeShowMenu = needSwipeShowMenu;
    if (needSwipeShowMenu) {
        [baseView addGestureRecognizer:panGestureRecognizer];
    } else {
        [baseView removeGestureRecognizer:panGestureRecognizer];
    }
}

- (void)resetCurrentViewToMainViewController {
    if (currentView != _mainViewController.view) {
        CGRect frame = CGRectZero;
        CGAffineTransform transform = CGAffineTransformIdentity;
        if (!currentView) {
            frame = baseView.bounds;
        } else {
            frame = currentView.frame;
            transform = currentView.transform;
        }
        [currentView removeFromSuperview];
        currentView = _mainViewController.view;
        [baseView addSubview:currentView];
        currentView.transform = transform;
        currentView.frame = frame;
        if (_leftViewController.view.superview || _rightViewController.view.superview) {
            [currentView addSubview:coverButton];
            [self showShadow:_needShowBoundsShadow];
        }
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == panGestureRecognizer) {
        //控制是否从视图的边缘触发弹出侧边试图
        if (_needPanFromViewBounds && [gestureRecognizer locationInView:currentView].x >= canTouchAreaWidth && [gestureRecognizer locationInView:currentView].x < currentView.frame.size.width - canTouchAreaWidth) {
            return NO;
        }
        UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint translation = [panGesture translationInView:baseView];
        if ([panGesture velocityInView:baseView].x < 600 && ABS(translation.x) / ABS(translation.y) > 1) {
            return YES;
        }
        return NO;
    }
    return YES;
}

//拦截下级视图的手势
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

//手势会传递到下级视图
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return YES;
//}

//手势派发给下级视图
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return YES;
//}

- (void)pan:(UIPanGestureRecognizer *)pan {
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        startPanPoint = currentView.frame.origin;
        if (currentView.frame.origin.x == 0) {
            [self showShadow:_needShowBoundsShadow];
        }
        CGPoint velocity = [pan velocityInView:baseView];
        if (velocity.x > 0) {
            if (currentView.frame.origin.x >= 0 && _leftViewController && !_leftViewController.view.superview) {
                [self willShowLeftViewController];
            }
        } else if (velocity.x < 0) {
            if (currentView.frame.origin.x <= 0 && _rightViewController && !_rightViewController.view.superview) {
                [self willShowRightViewController];
            }
        }
        return;
    }
    CGPoint currentPostion = [pan translationInView:baseView];
    CGFloat xOffset = startPanPoint.x + currentPostion.x;
    if (xOffset > 0) {
        if (_leftViewController && _leftViewController.view.superview) {
            xOffset = xOffset > _leftViewShowWidth ? _leftViewShowWidth : xOffset;
        } else {
            xOffset = 0;
        }
    } else if (xOffset < 0) {
        if (_rightViewController && _rightViewController.view.superview) {
            xOffset = xOffset < -_rightViewShowWidth ? -_rightViewShowWidth : xOffset;
        } else {
            xOffset = 0;
        }
    }
    if (xOffset != currentView.frame.origin.x) {
        [self layoutCurrentViewWithOffset:xOffset];
    }
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (currentView.frame.origin.x == 0) {
            [self showShadow:NO];
        } else {
            if (panMovingLeftOrRight && currentView.frame.origin.x > 20) {
                [self showLeftViewController:YES];
            } else if (!panMovingLeftOrRight && currentView.frame.origin.x < -20) {
                [self showRightViewController:YES];
            } else {
                [self hideSlideMenuViewController:YES];
            }
        }
    } else {
        CGPoint velocity = [pan velocityInView:baseView];
        if (velocity.x > 0) {
            panMovingLeftOrRight = YES;
        } else if (velocity.x < 0) {
            panMovingLeftOrRight = NO;
        }
    }
}

//重写此方法可以自定义mainViewController的出入动画
- (void)layoutCurrentViewWithOffset:(CGFloat)xOffset {
    CGFloat totalWidth = baseView.frame.size.width;
    CGFloat totalHeight = baseView.frame.size.height;
    if (_needShowBoundsShadow) {
        currentView.layer.shadowPath = [UIBezierPath bezierPathWithRect:currentView.bounds].CGPath;
    }
    if (_mainViewAnimationBlock) {
        //如果有自定义的动画,则执行自定义动画
        _mainViewAnimationBlock(currentView, baseView.bounds, xOffset);
        return;
    }
    if (_animationType == SlideAnimationTypeMove) {
        currentView.frame=CGRectMake(xOffset, baseView.bounds.origin.y, totalWidth, totalHeight);
    } else {
        CGFloat scale = ABS(totalHeight - ABS(xOffset)) / totalHeight;
        scale = MAX(0.8, scale);
        currentView.transform = CGAffineTransformMakeScale(scale, scale);
        if (xOffset > 0) {//右滑
            currentView.frame = CGRectMake(xOffset, baseView.bounds.origin.y + (totalHeight * (1 - scale) / 2), totalWidth * scale, totalHeight * scale);
        } else {//左滑
            currentView.frame = CGRectMake(baseView.frame.size.width * (1 - scale) + xOffset, baseView.bounds.origin.y + (totalHeight * (1 - scale) / 2), totalWidth * scale, totalHeight * scale);
        }
    }
}

- (void)willShowLeftViewController {
    if (!_leftViewController || _leftViewController.view.superview) {
        return;
    }
    _leftViewController.view.frame = baseView.bounds;
    [baseView insertSubview:_leftViewController.view belowSubview:currentView];
    if (_rightViewController && _rightViewController.view.superview) {
        [_rightViewController.view removeFromSuperview];
    }
}

- (void)willShowRightViewController {
    if (!_rightViewController || _rightViewController.view.superview) {
        return;
    }
    _rightViewController.view.frame = baseView.bounds;
    [baseView insertSubview:_rightViewController.view belowSubview:currentView];
    if (_leftViewController && _leftViewController.view.superview) {
        [_leftViewController.view removeFromSuperview];
    }
}

- (void)showShadow:(BOOL)show {
    currentView.layer.shadowOpacity = show ? 0.8f : 0.0f;
    if (show) {
        currentView.layer.cornerRadius = 4.0f;
        currentView.layer.shadowOffset = CGSizeZero;
        currentView.layer.shadowRadius = 4.0f;
        currentView.layer.shadowPath = [UIBezierPath bezierPathWithRect:currentView.bounds].CGPath;
    }
}

- (void)showLeftViewController:(BOOL)animated {
    if (!_leftViewController) {
        return;
    }
    [self willShowLeftViewController];
    NSTimeInterval animatedTime = 0;
    if (animated) {
        animatedTime = ABS(_leftViewShowWidth - currentView.frame.origin.x) / _leftViewShowWidth * _animationDuration;
    }
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView animateWithDuration:animatedTime animations:^{
        [self layoutCurrentViewWithOffset:_leftViewShowWidth];
        [currentView addSubview:coverButton];
        [self showShadow:_needShowBoundsShadow];
    }];
    canTouchAreaWidth = currentView.frame.size.width - _leftViewShowWidth;
}

- (void)showRightViewController:(BOOL)animated {
    if (!_rightViewController) {
        return;
    }
    [self willShowRightViewController];
    NSTimeInterval animatedTime = 0;
    if (animated) {
        animatedTime = ABS(_rightViewShowWidth - currentView.frame.origin.x) / _rightViewShowWidth * _animationDuration;
    }
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView animateWithDuration:animatedTime animations:^{
        [self layoutCurrentViewWithOffset:-_rightViewShowWidth];
        [currentView addSubview:coverButton];
        [self showShadow:_needShowBoundsShadow];
    }];
    canTouchAreaWidth = currentView.frame.size.width - _rightViewShowWidth;
}

- (void)hideSlideMenuViewController:(BOOL)animated {
    _needPanFromViewBounds = YES;
    [self showShadow:NO];
    NSTimeInterval animatedTime = 0;
    if (animated) {
        animatedTime = ABS(currentView.frame.origin.x / (currentView.frame.origin.x > 0 ? _leftViewShowWidth:_rightViewShowWidth)) * _animationDuration;
    }
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView animateWithDuration:animatedTime animations:^{
        [self layoutCurrentViewWithOffset:0];
    } completion:^(BOOL finished) {
        [coverButton removeFromSuperview];
        [_leftViewController.view removeFromSuperview];
        [_rightViewController.view removeFromSuperview];
    }];
    canTouchAreaWidth = 40;
}

- (void)hideSideViewController {
    [self hideSlideMenuViewController:YES];
}

@end
