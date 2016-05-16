//
//  StripePaymentViewController.m
//  signinDemo
//
//  Created by Annant Gupta on 5/12/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import "StripeCreateCardViewController.h"
#import "StripeHandler.h"
#import "UtilityClass.h"

@interface StripeCreateCardViewController ()<StripeHandlerDelegate>
@property StripeHandler *stripeHandler;
@property UITextField *selectedTextField;
@end

@implementation StripeCreateCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDatePicker];
    self.title = @"Create Card";
    [self.navigationItem.backBarButtonItem setTitle:@""];
    self.formValidator=[[FormValidator alloc]initWithFormInputs:@[[NSNumber numberWithInt:kFormValidatorFirstName], [NSNumber numberWithInt:kFormValidatorCardNumber],[NSNumber numberWithInt:kFormValidatorNonEmpty],[NSNumber numberWithInt:kFormValidatorCVC]]];
    self.createCardButton.enabled = false;
    self.noOfTextFields = 4;
    
    self.cardHolderName.delegate = self;
    self.cardHolderName.tag = 1;
    self.cardNumber.delegate = self;
    self.cardNumber.tag = 2;
    self.expiryDate.delegate = self;
    self.expiryDate.tag =3;
    self.cardCVC.delegate = self;
    self.cardCVC.tag =4;
    
    //Set Padding to textfields
    [UtilityClass setPaddingTextField:self.cardHolderName padding:10 toLeft:YES];
    [UtilityClass setPaddingTextField:self.cardNumber padding:10 toLeft:YES];
    [UtilityClass setPaddingTextField:self.expiryDate padding:10 toLeft:YES];
    [UtilityClass setPaddingTextField:self.cardCVC padding:10 toLeft:YES];
    
    // Do any additional setup after loading the view from its nib.
    self.stripeHandler = [[StripeHandler alloc] init];
    self.stripeHandler.delegate = self;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerHandler:)];
    [self.scrollView addGestureRecognizer:tapGestureRecognizer];
}

-(void)tapGestureRecognizerHandler:(id)sender{
    if(self.selectedTextField && [self.selectedTextField isFirstResponder]){
        [self.selectedTextField resignFirstResponder];
    }
}

-(void)setupDatePicker{
    UIDatePicker *expiryDatePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 250, self.view.frame.size.width, 250)];
    expiryDatePicker.backgroundColor = [UIColor colorWithRed:12/255.0 green:152/255.0 blue:204/255.0 alpha:1.0];
    [expiryDatePicker setValue:[UIColor whiteColor] forKey:@"textColor"];
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    UIBarButtonItem *done = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(didSelectDate:)];
    toolBar.items = @[done];
    self.expiryDate.inputAccessoryView = toolBar;
    expiryDatePicker.datePickerMode = UIDatePickerModeDate;
    self.expiryDate.inputView = expiryDatePicker;

}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.selectedTextField = textField;
}

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

    NSArray *inputValues = @[self.cardHolderName.text, self.cardNumber.text, self.expiryDate.text, self.cardCVC.text];
    
    self.createCardButton.enabled = [self.formValidator validateFormWithInputValues:inputValues inputStatus:^(int idx, validationResult result) {
        UITextField *textField = (UITextField *)[self.view viewWithTag:idx+1];
        textField.layer.masksToBounds=YES;
        textField.layer.borderWidth= 1.0f;
        if (result == kFormValidatorResultValid) {
            //            NSLog(@"Valid text : %@", textField.text);
            textField.layer.borderColor=[[UIColor greenColor]CGColor];
        }else if(result == kFormValidatorResultInvalid){
            //            NSLog(@"InValid");
            textField.layer.borderColor=[[UIColor redColor]CGColor];
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


-(void)didSelectDate:(id)sender{
    NSLog(@"date Selected:%@",[(UIDatePicker*)self.expiryDate.inputView date]);
    NSDate *expiryDate = [(UIDatePicker*)self.expiryDate.inputView date] ;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"MM/yyyy"];
    self.expiryDate.text = [dateFormat stringFromDate:expiryDate];
//    [self.expiryDate setText:[NSDateFormatter localizedStringFromDate:expiryDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]];
    [self.expiryDate resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)createCardClicked:(id)sender{
    NSDate *expiryDate = [(UIDatePicker*)self.expiryDate.inputView date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM"];
    NSUInteger expiryMonth = [[dateFormatter stringFromDate:expiryDate] intValue];
    [dateFormatter setDateFormat:@"yy"];
    NSUInteger expiryYear = [[dateFormatter stringFromDate:expiryDate] intValue];
    [self.stripeHandler createCardTokenWithCardHolderName:self.cardHolderName.text cardNumber:self.cardNumber.text expiryMonth:expiryMonth expiryYear:expiryYear cardCVC:self.cardCVC.text];
    
    
    
}


#pragma mark - StripeHandlerDelegateHelpers
-(void)didPaymentCompleted:(BOOL)success data:(NSString*)data{
    if(success){
        NSLog(@"card token:%@", data);
    }else{
        NSLog(@"error:N%@", data);
    }
    
}
@end
