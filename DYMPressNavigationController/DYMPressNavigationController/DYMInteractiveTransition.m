//
//  DYMInteractiveTransition.m
//  DYMPressNavigationController
//
//  Created by Dong Yiming on 15/12/29.
//  Copyright © 2015年 Dong Yiming. All rights reserved.
//

#import "DYMInteractiveTransition.h"

@interface DYMInteractiveTransition ()

@end

@implementation DYMInteractiveTransition

- (instancetype)init
{
    self = [super init];
    if (self) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    }
    return self;
}

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
            [self updateInteractiveTransition:percentComplete];
            break;
        }
            
        case UIGestureRecognizerStateEnded: {
            if (percentComplete <= 0.5) {
                [self finishInteractiveTransition];
            } else {
                [self cancelInteractiveTransition];
            }
            _isPanning = NO;
            break;
        }
            
        case UIGestureRecognizerStateCancelled: {
            [self cancelInteractiveTransition];
            _isPanning = NO;
            break;
        }
            
        default:
            break;
    }
}

@end
