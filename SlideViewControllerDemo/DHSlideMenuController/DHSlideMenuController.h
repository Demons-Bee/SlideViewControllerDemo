//
//  DHSlideMenuController.h
//  DHSlideMenuController
//
//  Created by 胡大函 on 14/10/11.
//  Copyright (c) 2014年 HuDahan_payMoreGainMore. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MainViewAnimationBlock) (UIView *mainView, CGRect orginFrame, CGFloat xOffset);
typedef NS_ENUM(NSInteger, SlideAnimationType) {
    SlideAnimationTypeScale,
    SlideAnimationTypeMove
};
@interface DHSlideMenuController : UIViewController

@property (assign, nonatomic) BOOL needSwipeShowMenu;
@property (assign, nonatomic) BOOL needShowBoundsShadow;
@property (assign, nonatomic) BOOL needPanFromViewBounds;

@property (strong, nonatomic) UIViewController *mainViewController;
@property (strong, nonatomic) UIViewController *leftViewController;
@property (strong, nonatomic) UIViewController *rightViewController;

@property (assign, nonatomic) CGFloat leftViewShowWidth;
@property (assign, nonatomic) CGFloat rightViewShowWidth;
@property (assign, nonatomic) NSTimeInterval animationDuration;

@property (copy, nonatomic) MainViewAnimationBlock mainViewAnimationBlock;
@property (assign, nonatomic) SlideAnimationType animationType;

+ (instancetype)sharedInstance;
- (instancetype)initWithMainViewController:(UIViewController *)main leftViewController:(UIViewController *)left rightViewController:(UIViewController *)right animationBlock:(MainViewAnimationBlock)block;
- (void)showLeftViewController:(BOOL)animated;
- (void)showRightViewController:(BOOL)animated;
- (void)hideSlideMenuViewController:(BOOL)animated;

@end
