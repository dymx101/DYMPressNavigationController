//
//  DYMInteractiveTransition.h
//  DYMPressNavigationController
//
//  Created by Dong Yiming on 15/12/29.
//  Copyright © 2015年 Dong Yiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYMInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, copy) dispatch_block_t                        didStartPanBlock;
@property (nonatomic, strong) UIPanGestureRecognizer                *panGesture;
@property (nonatomic, assign, readonly) BOOL                        isPanning;

@end
