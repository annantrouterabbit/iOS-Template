//
//  OAuthHandler.m
//  signinDemo
//
//  Created by Annant Gupta on 5/11/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import "OAuthHandler.h"

@implementation OAuthHandler

//invoked from appDelegate.m file
+(void)handleGoogleOAuthData:(GIDGoogleUser *)UserData{
    NSString *idToken = UserData.authentication.idToken; // Safe to send to the server
    NSString *fullName = UserData.profile.name;
    NSString *email = UserData.profile.email;
    [UtilityClass setUserDefaultsValueforKey:@"LoginToken" value:idToken];
    [UtilityClass setUserDefaultsValueforKey:@"Fullname" value:fullName];
    [UtilityClass setUserDefaultsValueforKey:@"Email" value:email];
    NSLog(@"Email Id :%@", email);
    // Uncomment just below line if you want to setup tab bar with drawer and navigation bar
    SWRevealViewController *viewController = [UtilityClass setupTabBarWithDrawerWithNavigationBar];
    
    // Uncomment just below line if you want to setup tab bar without drawer and with navigation bar
    //            UITabBarController *viewController = [UtilityClass setupTabBarWithoutDrawerWithNavigationBar];
    
    // Uncomment just below line  if you want to setup tab bar without drawer and navigation bar
    //        UITabBarController *viewController = [UtilityClass setupTabBarWithoutDrawerWithoutNavigationBar];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = viewController;

    
}

//invoked from LoginViewController.m and RegisterViewController.m file

+(void)handleFacebookOAuthData:(FBSDKLoginManagerLoginResult *)loginResult{
    NSString *token = loginResult.token.tokenString;
    if(token){
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"name, first_name, last_name,email"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                [UtilityClass setUserDefaultsValueforKey:@"LoginToken" value:(NSObject *)token];
                 [UtilityClass setUserDefaultsValueforKey:@"Fullname" value:(NSObject *)[result objectForKey:@"name"]];
                 [UtilityClass setUserDefaultsValueforKey:@"email" value:[result objectForKey:@"email"]];
                NSLog(@"FB Login Token:%@",token);
                 NSLog(@"FB User Data: %@", result);
                 // Uncomment just below line if you want to setup tab bar with drawer and navigation bar
                 SWRevealViewController *viewController = [UtilityClass setupTabBarWithDrawerWithNavigationBar];
                 
                 // Uncomment just below line if you want to setup tab bar without drawer and with navigation bar
                 //            UITabBarController *viewController = [UtilityClass setupTabBarWithoutDrawerWithNavigationBar];
                 
                 // Uncomment just below line  if you want to setup tab bar without drawer and navigation bar
                 //            UITabBarController *viewController = [UtilityClass setupTabBarWithoutDrawerWithoutNavigationBar];
                 UIWindow *window = [UIApplication sharedApplication].keyWindow;
                 window.rootViewController = viewController;
                
             }
             else
             {
                 NSLog(@"Error %@",error);
             }

         }];
    }

}

-(void)fetchFacebookUserInfo
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"name, first_name, last_name,email"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 NSLog(@"resultis:%@",result);
             }
             else
             {
                 NSLog(@"Error %@",error);
             }
         }];
        
    }
    
}



@end
