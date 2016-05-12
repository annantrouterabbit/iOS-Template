//
//  ViewController.m
//  walkthrough
//
//  Created by Ankit Pundhir on 11/05/16.
//  Copyright © 2016 Ankit Pundhir. All rights reserved.
//

#import "ViewController.h"
@import iosWalkthrough;

@interface ViewController ()<WalkthroughAuthenticationDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    WalkthroughContainer *walkthroughController = [[WalkthroughContainer alloc] initWithPlistName:@"WalkthroughScreens" withAnimationDuration:3];
    walkthroughController.delegate = self;
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController setViewControllers:@[walkthroughController]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WalkthroughAuthenticationHelpers

-(void)didAuthenticateLogin{
    NSLog(@"Login Clicked");
}

-(void)didAuthenticateRegister{
    NSLog(@"Register Clicked");
}

@end
