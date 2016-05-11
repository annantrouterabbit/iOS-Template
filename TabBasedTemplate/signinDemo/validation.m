//
//  validation.m
//  signinDemo
//
//  Created by Annant Gupta on 5/3/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import "validation.h"

@implementation validation
+(BOOL)isValidEmail:(NSString *)email{
    NSString *trimmedStr = [email stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //    NSLog(@"%@", trimmedStr);
    if(trimmedStr.length > 0){
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        return [emailTest evaluateWithObject:trimmedStr];
    }
    return false;
    
}

@end
