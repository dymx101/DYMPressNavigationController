//
//  ViewController.m
//  DYMPressNavigationController
//
//  Created by Dong Yiming on 15/12/29.
//  Copyright © 2015年 Dong Yiming. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
}

- (IBAction)actionPop:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionPush:(id)sender {
    ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
