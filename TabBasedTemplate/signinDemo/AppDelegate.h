//
//  AppDelegate.h
//  signinDemo
//
//  Created by Annant Gupta on 5/3/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>
#import "OAuthHandler.h"
#import "StripeHandler.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, GIDSignInDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

