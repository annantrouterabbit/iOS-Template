//
//  WalkthroughIndicators.h
//  walkthrough
//
//  Created by Ankit Pundhir on 11/05/16.
//  Copyright © 2016 Ankit Pundhir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WalkthroughIndicators : NSObject
@property UIColor *activeColor;
@property UIColor *inactiveColor;
@property UIColor *backgroundColor;

-(instancetype)initWithActiveColor:(UIColor*)activeColor withInactiveColor:(UIColor*)inactiveColor withBackgroundColor:(UIColor*)backgroundColor;
@end
