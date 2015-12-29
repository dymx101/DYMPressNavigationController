//
//  UIViewController+PressAnimationController.m
//  DYMPressNavigationController
//
//  Created by Dong Yiming on 15/12/29.
//  Copyright © 2015年 Dong Yiming. All rights reserved.
//

#import "UIViewController+PressAnimationController.h"
#import <objc/runtime.h>

static const void *kPushAnimationControllerKey = &kPushAnimationControllerKey;
static const void *kPopAnimationControllerKey = &kPopAnimationControllerKey;

@implementation UIViewController (PressAnimationController)

- (void)set_dym_press_pushAnimationController:(id<UIViewControllerAnimatedTransitioning>)animController
{
    objc_setAssociatedObject(self, kPushAnimationControllerKey, animController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (id<UIViewControllerAnimatedTransitioning>)dym_press_pushAnimationController
{
    return objc_getAssociatedObject(self, kPushAnimationControllerKey);
}


- (void)set_dym_press_popAnimationController:(id<UIViewControllerAnimatedTransitioning>)animController
{
    objc_setAssociatedObject(self, kPopAnimationControllerKey, animController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (id<UIViewControllerAnimatedTransitioning>)dym_press_popAnimationController
{
    return objc_getAssociatedObject(self, kPopAnimationControllerKey);
}

@end
