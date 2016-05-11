//
//  LoginViewController.m
//  firstDemoApp
//
//  Created by Annant Gupta on 5/2/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import "LoginViewController.h"

#define GOOGLECLIENTID  @"6783008446-8k1bb893lv65j9aj7srfc4777rqp48u4.apps.googleusercontent.com"
@interface LoginViewController ()


@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setup formValidator type for form textfield
    _noOfTextFields =2;
    self.formValidator = [[FormValidator alloc]initWithFormInputs:@[[NSNumber numberWithInt:kFormValidatorEmail], [NSNumber numberWithInt:kFormValidatorPassword]]];
    
    //setup facebook permission and delegate for facebook button
    _fbLoginButton.readPermissions = @[@"public_profile",@"email"];
    [_fbLoginButton setDelegate:self];
    
    //setup google button delegate for UI
    [GIDSignIn sharedInstance].uiDelegate = self;
    
    //set textfield's delegates and assign tag id through which textfields are going to be identified in code
    _Uname.delegate = self;
    _Uname.tag = 1;
    _Password.delegate = self;
    _Password.tag = 2;
    
    //other setup
    self.title= @"Login";
    self.home = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];

    
        // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.signInButton.enabled = false;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(IBAction)SignIn_click:(id)sender{
    if([validation isValidEmail:_Uname.text]){
        if([_Uname.text  isEqualToString: @"annant@gmail.com"] && [_Password.text isEqualToString:@"abcd1234"]){
            NSLog(@"authenticated");
            NSString *loginToken = @"klskjdkj387kljsldfj!";
            [UtilityClass setUserDefaultsValueforKey:@"LoginToken" value:loginToken];
//            UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:self.home];
//            [self presentViewController:navigationController animated:YES completion: nil];
            
// Uncomment just below line if you want to setup tab bar with drawer and navigation bar
            SWRevealViewController *viewController = [UtilityClass setupTabBarWithDrawerWithNavigationBar];
            
// Uncomment just below line if you want to setup tab bar without drawer and with navigation bar
//            UITabBarController *viewController = [UtilityClass setupTabBarWithoutDrawerWithNavigationBar];
            
// Uncomment just below line  if you want to setup tab bar without drawer and navigation bar
//            UITabBarController *viewController = [UtilityClass setupTabBarWithoutDrawerWithoutNavigationBar];
            [self presentViewController:viewController  animated:YES completion: nil];
            
        }
        
    }

}


- (IBAction)fbButtonClicked:(id)sender {
//    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
//    [loginManager logInWithReadPermissions:@[@"public_profile",@"email"]
//                        fromViewController:self
//                                   handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//                                       //TODO: process error or result
//                                       NSLog(@"result%@, error%@",result , error);
//                                       if(error){
//                                           
//                                       }
//                                   }];
}

- (IBAction)createAccountClicked:(id)sender {
    RegisterViewController *registerViewController = [[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
    registerViewController.title = @"Register";
    [self.navigationController pushViewController:registerViewController animated:YES];
}

- (void) loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:  (FBSDKLoginManagerLoginResult *)result
                error:  (NSError *)error{
    if(!error){
        [OAuthHandler handleFacebookOAuthData:result];
    } else{
        NSLog(@"Facebooke login error :%@", error);
    }

//    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:self.home];

    
    
}
- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    NSLog(@"facebook logout button test");
}

#pragma textfield delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSInteger tag = [textField tag];
    if (tag > self.noOfTextFields) {
        [textField resignFirstResponder];
        return YES;
    }
    
    NSInteger nextTag = tag + 1;
    UITextField *next = (UITextField*)[self.view viewWithTag:nextTag];
    [textField resignFirstResponder];
    [next becomeFirstResponder];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    UITextPosition *beginning = textField.beginningOfDocument;
    UITextPosition *cursorLocation = [textField positionFromPosition:beginning offset:(range.location + string.length)];
    
    textField.text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSArray *inputValues = @[self.Uname.text,self.Password.text];
    
    self.signInButton.enabled = [self.formValidator validateFormWithInputValues:inputValues inputStatus:^(int idx, validationResult result) {
        UITextField *textField = (UITextField *)[self.view viewWithTag:idx+1];
        textField.layer.masksToBounds=YES;
        textField.layer.borderWidth= 1.0f;
        if (result == kFormValidatorResultValid) {
            //            NSLog(@"Valid text : %@", textField.text);
            textField.layer.borderColor=[[UIColor greenColor]CGColor];
            textField.borderStyle = UITextBorderStyleRoundedRect;
        }else if(result == kFormValidatorResultInvalid){
            //            NSLog(@"InValid");
            textField.layer.borderColor=[[UIColor redColor]CGColor];
            textField.borderStyle = UITextBorderStyleRoundedRect;
        }else{
            //            NSLog(@"Default");
            textField.layer.borderColor = [[UIColor clearColor]CGColor];
            
        }
        
    }];
    // cursorLocation will be (null) if you're inputting text at the end of the string
    // if already at the end, no need to change location as it will default to end anyway
    if(cursorLocation)
    {
        // set start/end location to same spot so that nothing is highlighted
        [textField setSelectedTextRange:[textField textRangeFromPosition:cursorLocation toPosition:cursorLocation]];
    }
    return NO;
}



//- (IBAction)googleSignInClicked:(id)sender {
//    NSError* configureError;
//    [GIDSignIn sharedInstance].clientID = GOOGLECLIENTID;
//    //connect your AppDelegate to the google's GGLContext
//    [[GGLContext sharedInstance] configureWithError: &configureError];
//    if(configureError != nil){
//        NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
//    } else{
//        [GIDSignIn sharedInstance].shouldFetchBasicProfile = true;
//        
//        [GIDSignIn sharedInstance].delegate = self;
//        [GIDSignIn sharedInstance].uiDelegate = self;
//        [GIDSignIn sharedInstance].allowsSignInWithBrowser = false;
//        [GIDSignIn sharedInstance].allowsSignInWithWebView = true;
//        [[GIDSignIn sharedInstance] signIn];
//    }
//
//    
//
//}
//- (void)signIn:(GIDSignIn *)signIn
//didSignInForUser:(GIDGoogleUser *)user
//     withError:(NSError *)error {
//    // Perform any operations on signed in user here.
//    //NSString *userId = user.userID;                  // For client-side use only!
//    if(error){
//        NSLog(@"error:%@", error);
//    } else{
//        NSString *idToken = user.authentication.idToken; // Safe to send to the server
//        NSString *fullName = user.profile.name;
//        NSString *email = user.profile.email;
//        [UtilityClass setUserDefaultsValueforKey:@"LoginToken" value:idToken];
//        [UtilityClass setUserDefaultsValueforKey:@"Fullname" value:fullName];
//        [UtilityClass setUserDefaultsValueforKey:@"Email" value:email];
//        //        HomeViewController *home = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
//        //        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:home];
//        //        self.window.rootViewController = navigationController;
//        [self setupDrawerAndNavigateToHome];
//    }
//    // ...
//}

@end
