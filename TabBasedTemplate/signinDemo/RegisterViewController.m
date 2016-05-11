//
//  RegisterViewController.m
//  signinDemo
//
//  Created by Annant Gupta on 5/10/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import "RegisterViewController.h"
#import "FormValidator.h"

@interface RegisterViewController ()
@property int noOfTextFields;
@property UITextField *activeTextfield;
@property FormValidator *formValidator;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setup formValidator type for form's textfield
    _noOfTextFields = 5;
    self.formValidator = [[FormValidator alloc]initWithFormInputs:@[[NSNumber numberWithInt:kFormValidatorFirstName], [NSNumber numberWithInt:kFormValidatorLastName], [NSNumber numberWithInt:kFormValidatorEmail], [NSNumber numberWithInt:kFormValidatorPassword], [NSNumber numberWithInt:kFormValidatorPassword]]];
    //setup validator of equality between password and re-type password textfield
    [self.formValidator addRelationship:kFormValidatorRelationshipEqual toValidationItemAtIndex:4 dependentUponValidatonItemsAtIndexes:[NSIndexSet indexSetWithIndex:3]];
    
    //set facebook read permission and button delegate
    _fbLoginButton.readPermissions = @[@"public_profile",@"email"];
    [_fbLoginButton setDelegate:self];
    
    //set google read permission and button delegate
    [GIDSignIn sharedInstance].uiDelegate = self;
    
    //set textfield's delegates and assign unique tag id to each textfield through which they are going to be identified in code
    _firstName.delegate = self;
    _firstName.tag = 1;
    _lastName.delegate = self;
    _lastName.tag =2;
    _emailAddress.delegate = self;
    _emailAddress.tag =3;
    _password.delegate = self;
    _password.tag =4;
    _reTypePassword.delegate = self;
    _reTypePassword.tag =5;
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.registerButton.enabled = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self contentView] endEditing:YES];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)registerClicked:(id)sender {
    NSDictionary *registrationData = @{@"first_name":_firstName.text,@"last_name":_lastName.text,@"email_id":_emailAddress.text,@"password":_password.text,@"confirm_password":_reTypePassword.text};
    NSLog(@"Registration Data:%@", registrationData);
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



-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    NSLog(@"Begin Editing");
    self.activeTextfield = textField;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.activeTextfield = nil;
//     NSLog(@"End Editing");
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    UITextPosition *beginning = textField.beginningOfDocument;
    UITextPosition *cursorLocation = [textField positionFromPosition:beginning offset:(range.location + string.length)];
    
    textField.text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSArray *inputValues = @[self.firstName.text, self.lastName.text, self.emailAddress.text, self.password.text, self.reTypePassword.text];
    
    self.registerButton.enabled = [self.formValidator validateFormWithInputValues:inputValues inputStatus:^(int idx, validationResult result) {
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




@end
