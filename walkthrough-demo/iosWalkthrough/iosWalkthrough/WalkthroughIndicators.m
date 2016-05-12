//
//  WalkthroughIndicators.m
//  walkthrough
//
//  Created by Ankit Pundhir on 11/05/16.
//  Copyright © 2016 Ankit Pundhir. All rights reserved.
//

#import "WalkthroughIndicators.h"

@implementation WalkthroughIndicators
-(instancetype)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.activeColor = [UIColor darkGrayColor];
    self.inactiveColor = [UIColor lightGrayColor];
    self.backgroundColor = [UIColor blackColor];
    return self;
}

-(instancetype)initWithActiveColor:(UIColor*)activeColor withInactiveColor:(UIColor*)inactiveColor withBackgroundColor:(UIColor*)backgroundColor{
    self = [super init];
    if(!self){
        return nil;
    }
    
    self.activeColor = activeColor;
    self.inactiveColor = inactiveColor;
    self.backgroundColor = backgroundColor;
    return self;
}
@end
