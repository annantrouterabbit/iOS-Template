//
//  UtilityClass.m
//  signinDemo
//
//  Created by Annant Gupta on 5/5/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import "UtilityClass.h"
#import <SWRevealViewController.h>
#import "MainMenuViewController.h"
#import "HomeViewController.h"
#import "MemberListViewController.h"

@implementation UtilityClass

+(NSObject *)getUserDefaultsValueforKey:(NSString *)key{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    return[preferences objectForKey:key];
    
}
+(void)setUserDefaultsValueforKey:(NSString *)key value:(NSObject *)value{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setObject:value forKey:key];
    [preferences synchronize];
}
+(void)removeUserDefaultsValueforKey:(NSString *)key{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences removeObjectForKey:key];
    [preferences synchronize];
}

+ (SWRevealViewController *) setupTabBarWithDrawerWithNavigationBar{
    MainMenuViewController *leftMenu = [[MainMenuViewController alloc]initWithNibName:@"MainMenuViewController" bundle:nil];
    MemberListViewController *memberListViewController = [[MemberListViewController alloc]initWithNibName:@"MemberListViewController" bundle:nil];
    HomeViewController *home = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    [home.tabBarItem setTitle:@"Home"];
    home.tabBarItem.image = [UIImage imageNamed:@"HomeIcon"];
    [memberListViewController.tabBarItem setTitle:@"Member List"];
    [memberListViewController setTitle:@"Member List"];
    memberListViewController.tabBarItem.image =[UIImage imageNamed:@"ListIcon"];
    UINavigationController *navigationControllerForHome =[[UINavigationController alloc] initWithRootViewController:home];
    UINavigationController *navigationControllerForMemberList =[[UINavigationController alloc] initWithRootViewController:memberListViewController];
    UITabBarController *tabBarController = [[UITabBarController alloc]init];
    [tabBarController setViewControllers:[NSArray arrayWithObjects:navigationControllerForHome, navigationControllerForMemberList, nil]];
    return[[SWRevealViewController alloc]initWithRearViewController:leftMenu frontViewController:tabBarController];
}

+(UITabBarController *)setupTabBarWithoutDrawerWithNavigationBar{
    MemberListViewController *memberListViewController = [[MemberListViewController alloc]initWithNibName:@"MemberListViewController" bundle:nil];
    HomeViewController *home = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    [home.tabBarItem setTitle:@"Home"];
    home.tabBarItem.image = [UIImage imageNamed:@"HomeIcon"];
    [memberListViewController.tabBarItem setTitle:@"Member List"];
    [memberListViewController setTitle:@"Member List"];
    memberListViewController.tabBarItem.image =[UIImage imageNamed:@"ListIcon"];
    UINavigationController *navigationControllerForHome =[[UINavigationController alloc] initWithRootViewController:home];
    UINavigationController *navigationControllerForMemberList =[[UINavigationController alloc] initWithRootViewController:memberListViewController];
    UITabBarController *tabBarController = [[UITabBarController alloc]init];
    [tabBarController setViewControllers:[NSArray arrayWithObjects:navigationControllerForHome, navigationControllerForMemberList, nil]];
    return tabBarController;
}

+(UITabBarController *)setupTabBarWithoutDrawerWithoutNavigationBar{
    MemberListViewController *memberListViewController = [[MemberListViewController alloc]initWithNibName:@"MemberListViewController" bundle:nil];
    HomeViewController *home = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    [home.tabBarItem setTitle:@"Home"];
    home.tabBarItem.image = [UIImage imageNamed:@"HomeIcon"];
    [memberListViewController.tabBarItem setTitle:@"Member List"];
    [memberListViewController setTitle:@"Member List"];
    memberListViewController.tabBarItem.image =[UIImage imageNamed:@"ListIcon"];
    UITabBarController *tabBarController = [[UITabBarController alloc]init];
    [tabBarController setViewControllers:[NSArray arrayWithObjects:home, memberListViewController, nil]];
    return tabBarController;


}

+(void)setPaddingTextField:(UITextField*)textField padding:(NSUInteger)padding toLeft:(BOOL)left{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, padding, 42)];
    if(left){
        textField.leftView = paddingView;
        textField.leftViewMode = UITextFieldViewModeAlways;
    }else{
        textField.rightView = paddingView;
        textField.rightViewMode = UITextFieldViewModeAlways;
    }
}

@end
