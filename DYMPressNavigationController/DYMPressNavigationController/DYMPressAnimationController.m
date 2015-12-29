//
//  DYMPressAnimationController.m
//  DYMPressNavigationController
//
//  Created by Dong Yiming on 15/12/29.
//  Copyright © 2015年 Dong Yiming. All rights reserved.
//

#import "DYMPressAnimationController.h"

@interface DYMPressAnimationController () {
    NSTimeInterval      _duration;
}

@property (nonatomic, assign)  BOOL     reversed;

@end

@implementation DYMPressAnimationController

-(instancetype)initWithReversed:(BOOL)reversed {
    self = [super init];
    if (self) {
        _duration = 0.5;
        _reversed = reversed;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return _duration;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [[transitionContext containerView] addSubview:toVC.view];
    
    
    if (self.reversed) {
        toVC.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } else {
        toVC.view.transform = CGAffineTransformMakeTranslation(toVC.view.frame.size.width, 0);
    }
    
    [UIView animateWithDuration:_duration delay:0 options:0 animations:^{
        
        if (self.reversed) {
            
            toVC.view.transform = CGAffineTransformIdentity;
            toVC.view.alpha = 1;
            
            fromVC.view.transform = CGAffineTransformMakeTranslation(toVC.view.frame.size.width, 0);
            
        } else {
            
            fromVC.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
            fromVC.view.alpha = 0.5;
            toVC.view.transform = CGAffineTransformIdentity;
        }
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:YES];
    }];
}

@end
