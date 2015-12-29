//
//  DYMPressNavigationController.m
//  DYMPressNavigationController
//
//  Created by Dong Yiming on 15/12/29.
//  Copyright © 2015年 Dong Yiming. All rights reserved.
//

#import "DYMPressNavigationController.h"
#import "DYMPressAnimationController.h"
#import "DYMInteractiveTransition.h"
#import "UIViewController+PressAnimationController.h"

@interface DYMPressNavigationController () <UINavigationControllerDelegate> 

@end

@implementation DYMPressNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    
    DYMPressAnimationController *pushAnimCtrl = [[DYMPressAnimationController alloc] initWithReversed:NO];
    [viewController set_dym_press_pushAnimationController:pushAnimCtrl];
    
    DYMPressAnimationController *popAnimCtrl = [[DYMPressAnimationController alloc] initWithReversed:YES];
    [viewController set_dym_press_popAnimationController:popAnimCtrl];
    
    //
    DYMInteractiveTransition *interactiveTransition = [DYMInteractiveTransition new];
    __weak typeof (self) ws = self;
    interactiveTransition.didStartPanBlock = ^(void) {
        __strong typeof (self) ss = ws;
        [ss popViewControllerAnimated:YES];
    };
    pushAnimCtrl.interactiveTransition = interactiveTransition;
    popAnimCtrl.interactiveTransition = interactiveTransition;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController.dym_press_popAnimationController isKindOfClass:[DYMPressAnimationController class]]) {
        DYMPressAnimationController *animController = (DYMPressAnimationController *)viewController.dym_press_popAnimationController;
        [viewController.view addGestureRecognizer:animController.interactiveTransition.panGesture];
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        
        return toVC.dym_press_pushAnimationController;
        
    } else if (operation == UINavigationControllerOperationPop) {
        
        return fromVC.dym_press_popAnimationController;
    }
    
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    if ([animationController isKindOfClass:[DYMPressAnimationController class]]) {
        DYMPressAnimationController *animController = (DYMPressAnimationController *)animationController;
        if (!animController.interactiveTransition.isPanning) {
            return animController.interactiveTransition;
        }
    }
    
    return nil;
}

@end
