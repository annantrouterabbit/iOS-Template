//
//  WalkthroughScreen.h
//  walkthrough
//
//  Created by Ankit Pundhir on 11/05/16.
//  Copyright © 2016 Ankit Pundhir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WalkthroughScreen : UIViewController

@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) IBOutlet UILabel *screenTitle;
@property (strong, nonatomic) IBOutlet UILabel *screenCaption;
@property (strong, nonatomic) IBOutlet UIImageView *screenImage;


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withIndex:(NSUInteger)index withTitle:(NSString *)title withCaption:(NSString *)caption withImage:(NSString*)image;
@end
