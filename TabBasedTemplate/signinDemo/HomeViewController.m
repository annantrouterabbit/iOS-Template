//
//  HomeViewController.m
//  signinDemo
//
//  Created by Annant Gupta on 5/3/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import <SWRevealViewController.h>

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Home";
    [self.navigationItem.backBarButtonItem setTitle:@""];
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    //Add an image to your project & set that image here.
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"LeftMenu"]style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
//    UIView *menuView = [[[NSBundle mainBundle]loadNibNamed:@"MenuView" owner:self options:nil] objectAtIndex:0];
//    [NavigationBar navigationBarWithLeftMenu:self.navigationItem centerView:self.navigationController.view menuView:menuView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)logout_clicked:(id)sender {
    [[FBSDKLoginManager new]logOut];
    [[GIDSignIn sharedInstance] disconnect];
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences removeObjectForKey:@"LoginToken"];
    NSLog(@"logintoken: %@", [preferences objectForKey:@"LoginToken"]);
    LoginViewController *lvc = [[LoginViewController alloc]initWithNibName:@"LoginView" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:lvc];
    [self presentViewController:navigationController animated:YES completion: nil];
}

@end
