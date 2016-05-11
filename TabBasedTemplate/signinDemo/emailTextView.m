//
//  emailTextView.m
//  signinDemo
//
//  Created by Annant Gupta on 5/3/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import "emailTextView.h"

@implementation emailTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(BOOL)shouldChangeTextInRange:(UITextRange *)range replacementText:(NSString *)text{
    NSLog(@"%@", text);
    return true;
    
}



@end
