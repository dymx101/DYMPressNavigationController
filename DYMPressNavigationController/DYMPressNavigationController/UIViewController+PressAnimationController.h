//
//  UIViewController+PressAnimationController.h
//  DYMPressNavigationController
//
//  Created by Dong Yiming on 15/12/29.
//  Copyright © 2015年 Dong Yiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PressAnimationController)

- (void)set_dym_press_pushAnimationController:(id<UIViewControllerAnimatedTransitioning>)animController;

- (id<UIViewControllerAnimatedTransitioning>)dym_press_pushAnimationController;

- (void)set_dym_press_popAnimationController:(id<UIViewControllerAnimatedTransitioning>)animController;

- (id<UIViewControllerAnimatedTransitioning>)dym_press_popAnimationController;

@end
