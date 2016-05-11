//
//  NavigationBar.h
//  signinDemo
//
//  Created by Annant Gupta on 5/6/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationBar : UINavigationBar

+(void)navigationBarWithLeftMenu :(UINavigationItem*)navigationCtrl centerView:(UIView *)centerView menuView:(UIView *)menuView;

@end
