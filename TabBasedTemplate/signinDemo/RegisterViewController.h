//
//  RegisterViewController.h
//  signinDemo
//
//  Created by Annant Gupta on 5/10/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAuthHandler.h"
@class GIDSignInButton;
@interface RegisterViewController : UIViewController    <FBSDKLoginButtonDelegate, GIDSignInUIDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *fbLoginButton;
@property (weak, nonatomic) IBOutlet GIDSignInButton *googleSignInButton;
- (IBAction)registerClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *emailAddress;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *reTypePassword;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end
