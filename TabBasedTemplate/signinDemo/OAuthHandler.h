//
//  OAuthHandler.h
//  signinDemo
//
//  Created by Annant Gupta on 5/11/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Google/SignIn.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "UtilityClass.h"

@interface OAuthHandler : NSObject
@property (strong, nonatomic) UIWindow *window;
+(void)handleGoogleOAuthData :(GIDGoogleUser *)data;
+(void)handleFacebookOAuthData :(FBSDKLoginManagerLoginResult *)loginResult;
@end
