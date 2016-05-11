//
//  UtilityClass.h
//  signinDemo
//
//  Created by Annant Gupta on 5/5/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SWRevealViewController.h>

@interface UtilityClass : NSObject
+(NSObject *)getUserDefaultsValueforKey:(NSString *)key;
+(void)setUserDefaultsValueforKey: (NSString *)key value:(NSObject *)value;
+(void)removeUserDefaultsValueforKey:(NSString *)key;
+ (SWRevealViewController *) setupTabBarWithDrawerWithNavigationBar;
+ (UITabBarController *) setupTabBarWithoutDrawerWithNavigationBar;
+ (UITabBarController *) setupTabBarWithoutDrawerWithoutNavigationBar;
@property (weak, nonatomic) NSUserDefaults *preferences;


@end
