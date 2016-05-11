//
//  LoginViewController.h
//  firstDemoApp
//
//  Created by Annant Gupta on 5/2/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>
#import "OAuthHandler.h"
#import "validation.h"
#import "HomeViewController.h"
#import "RegisterViewController.h"
#import "FormValidator.h"
@class SWRevealViewController;
@class GIDSignInButton;
@interface LoginViewController : UIViewController<GIDSignInUIDelegate, FBSDKLoginButtonDelegate, UITextFieldDelegate>
- (IBAction)SignIn_click:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *Uname;
@property (weak, nonatomic) IBOutlet UITextField *Password;
@property HomeViewController *home;
@property FormValidator *formValidator;
@property int noOfTextFields;
- (IBAction)fbButtonClicked:(id)sender;
- (IBAction)createAccountClicked:(id)sender;
@property (strong, nonatomic)UIView *loginView;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *fbLoginButton;
@property (weak, nonatomic) IBOutlet GIDSignInButton *googleSignButton;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;

//- (IBAction)googleSignInClicked:(id)sender;


@end
