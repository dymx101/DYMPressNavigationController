//
//  DYMPressAnimationController.h
//  DYMPressNavigationController
//
//  Created by Dong Yiming on 15/12/29.
//  Copyright © 2015年 Dong Yiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYMInteractiveTransition.h"

@interface DYMPressAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) DYMInteractiveTransition    *interactiveTransition;

-(instancetype)initWithReversed:(BOOL)reversed;

@end
