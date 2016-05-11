//
//  ViewController.m
//  signinDemo
//
//  Created by Annant Gupta on 5/3/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import "RootViewController.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "UtilityClass.h"

@interface RootViewController ()


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = true;
//    NSString *obj = [UtilityClass getUserDefaultsValueforKey:@"LoginToken"];
//    //    [self setupFacebook];
//    NSLog(@"accessToken:%@", obj);
//    if(obj && obj.length){
//        HomeViewController *home = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
//        UINavigationController *navigationController =[[UINavigationController alloc] initWithRootViewController:home];
//        [self presentViewController:navigationController animated:YES completion: nil];
//        
//    } else{
//        //    NSLog(@"%@", obj);
//        //    _loginView = [[[NSBundle mainBundle]loadNibNamed:@"LoginView" owner:self options:nil] firstObject];
//        //    _loginView.frame = _rootView.frame;
//        //    [_loginView endEditing:YES];
//        //    [_rootView addSubview:_loginView];
//        LoginViewController *login = [[LoginViewController alloc]initWithNibName:@"LoginView" bundle:nil];
//        UINavigationController *navigationController =[[UINavigationController alloc] initWithRootViewController:login];
//        [self presentViewController:navigationController animated:YES completion: nil];
//
//        
//    }
//
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidAppear:(BOOL)animated{
    NSString *obj = (NSString *)[UtilityClass getUserDefaultsValueforKey:@"LoginToken"];
    //    [self setupFacebook];
    NSLog(@"accessToken:%@", obj);
    if(obj && obj.length){
// Uncomment just below line if you want to setup tab bar with drawer and navigation bar
            SWRevealViewController *viewController = [UtilityClass setupTabBarWithDrawerWithNavigationBar];
        
// Uncomment just below line if you want to setup tab bar without drawer and with navigation bar
//            UITabBarController *viewController = [UtilityClass setupTabBarWithoutDrawerWithNavigationBar];
        
// Uncomment just below line  if you want to setup tab bar without drawer and navigation bar
//        UITabBarController *viewController = [UtilityClass setupTabBarWithoutDrawerWithoutNavigationBar];
        [self presentViewController:viewController animated:YES completion: nil];
        
    } else{
        self.title = @"SignIn";
        //    NSLog(@"%@", obj);
        //    _loginView = [[[NSBundle mainBundle]loadNibNamed:@"LoginView" owner:self options:nil] firstObject];
        //    _loginView.frame = _rootView.frame;
        //    [_loginView endEditing:YES];
        //    [_rootView addSubview:_loginView];
        LoginViewController *login = [[LoginViewController alloc]initWithNibName:@"LoginView" bundle:nil];
        UINavigationController *navigationController =[[UINavigationController alloc] initWithRootViewController:login];
        [self presentViewController:navigationController animated:YES completion: nil];
        
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
