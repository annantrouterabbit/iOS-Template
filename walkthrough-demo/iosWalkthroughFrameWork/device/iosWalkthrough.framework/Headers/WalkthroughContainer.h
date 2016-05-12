//
//  WalkthroughContainer.h
//  walkthrough
//
//  Created by Ankit Pundhir on 11/05/16.
//  Copyright © 2016 Ankit Pundhir. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WalkthroughAuthenticationDelegate <NSObject>

@required
-(void)didAuthenticateLogin;
-(void)didAuthenticateRegister;

@end

@interface WalkthroughContainer : UIViewController

@property (strong,nonatomic) NSArray *screens;
@property (strong,nonatomic) NSString *screenNibName;
@property (strong,nonatomic) NSBundle *screenNibBundle;
@property (strong,nonatomic) UIPageViewController *pageViewController;
@property NSUInteger animationDuration;
@property NSUInteger screenIndex;

@property (strong,nonatomic) NSString *screensDictionary;

@property (weak,nonatomic) id<WalkthroughAuthenticationDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *signup;
@property (weak, nonatomic) IBOutlet UIButton *login;

- (IBAction)registerAccount:(id)sender;

- (IBAction)loginAccount:(id)sender;

-(void)setButtonTextColor:(UIColor*)textColor;

+(void)setIndicators:(id)indicators;
+(void)setDefaultIndicators;

-(instancetype)initInsideController:(UIViewController*)controller withPlistName:(NSString*)plistName withAnimationDuration:(NSUInteger)duration;

@end
