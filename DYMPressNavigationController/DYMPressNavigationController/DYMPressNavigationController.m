//
//  DYMPressNavigationController.m
//  DYMPressNavigationController
//
//  Created by Dong Yiming on 15/12/29.
//  Copyright © 2015年 Dong Yiming. All rights reserved.
//

#import "DYMPressNavigationController.h"
#import "DYMPressAnimationController.h"
//#import "DYMInteractiveTransition.h"

@interface DYMPressNavigationController () <UINavigationControllerDelegate> {
//    DYMInteractiveTransition    *_interactiveTransition;
    UIPercentDrivenInteractiveTransition    *_interactTransition;
}

@property (nonatomic, copy) dispatch_block_t                        didStartPanBlock;
@property (nonatomic, strong) UIPanGestureRecognizer                *panGesture;
@property (nonatomic, assign, readonly) BOOL                        isPanning;

@end

@implementation DYMPressNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    
    _interactTransition = [UIPercentDrivenInteractiveTransition new];
    __weak typeof (self) ws = self;
    self.didStartPanBlock = ^(void) {
        __strong typeof (self) ss = ws;
        [ss popViewControllerAnimated:YES];
    };
    
    self.delegate = self;
}


#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [viewController.view addGestureRecognizer:_panGesture];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        
        return [[DYMPressAnimationController alloc] initWithReversed:NO];
        
    } else if (operation == UINavigationControllerOperationPop) {
        
        return [[DYMPressAnimationController alloc] initWithReversed:YES];
    }
    
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
//    if (!_isPanning) {
//        return _interactTransition;
//    }
    
    return nil;
}


#pragma mark - UIPanGestureRecognizer handler
-(void)handlePan:(UIPanGestureRecognizer *)panGest {
    
    CGPoint location = [panGest locationInView:panGest.view];
    CGFloat percentComplete = location.x / panGest.view.frame.size.width;
    
    switch (panGest.state) {
            
        case UIGestureRecognizerStateBegan: {
            _isPanning = YES;
            if (self.didStartPanBlock) {
                self.didStartPanBlock();
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            [_interactTransition updateInteractiveTransition:percentComplete];
            break;
        }
            
        case UIGestureRecognizerStateEnded: {
            if (percentComplete <= 0.5) {
                [_interactTransition finishInteractiveTransition];
            } else {
                [_interactTransition cancelInteractiveTransition];
            }
            _isPanning = NO;
            break;
        }
            
        case UIGestureRecognizerStateCancelled: {
            [_interactTransition cancelInteractiveTransition];
            _isPanning = NO;
            break;
        }
            
        default:
            break;
    }
}

@end
