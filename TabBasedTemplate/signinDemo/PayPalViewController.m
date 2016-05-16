//
//  PayPalViewController.m
//  signinDemo
//
//  Created by Annant Gupta on 5/13/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import "PayPalViewController.h"
#import "PayPalHandler.h"
#import "PayPalMobile.h"
#import "UtilityClass.h"

@interface PayPalViewController ()<PayPalPaymentDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate>
@property PayPalHandler *payPalHandler;
@property NSArray *currencyTypeArray;
@property UIPickerView *currencyPicker;
@property (nonatomic, strong, readwrite) PayPalConfiguration *payPalConfiguration;
@end

@implementation PayPalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.currencyTypeArray = @[@"USD", @"INR"];
    
    //paypal configuration
    _payPalConfiguration = [[PayPalConfiguration alloc] init];
    
    // See PayPalConfiguration.h for details and default values.
    // Should you wish to change any of the values, you can do so here.
    // For example, if you wish to accept PayPal but not payment card payments, then add:
    _payPalConfiguration.acceptCreditCards = YES;
    // Or if you wish to have the user choose a Shipping Address from those already
    // associated with the user's PayPal account, then add:
    _payPalConfiguration.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
    
    _amount.delegate = self;
    _paymentDescription.delegate = self;
    [self setupCurrencyTypePicker];
    
    //set padding to left of textfield
    [UtilityClass setPaddingTextField:self.amount padding:10 toLeft:YES];
    [UtilityClass setPaddingTextField:self.currencyType padding:10 toLeft:YES];
    
    
}

-(void)setupCurrencyTypePicker{
    _currencyPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height -250, self.view.frame.size.width, 250)];
    _currencyPicker.backgroundColor = [UIColor colorWithRed:12/255.0 green:152/255.0 blue:204/255.0 alpha:1.0];
    [_currencyPicker setValue:[UIColor whiteColor] forKey:@"textColor"];
    _currencyPicker.delegate =self;
    _currencyPicker.dataSource = self;
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    UIBarButtonItem *done = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(didSelectCurrencyType:)];
    toolBar.items = @[done];
    self.currencyType.inputAccessoryView = toolBar;
    self.currencyType.inputView = _currencyPicker;

}

-(void)didSelectCurrencyType:(id)sender{
    NSLog(@"currencyType selected");
    self.currencyType.text = [self.currencyTypeArray objectAtIndex:[self.currencyPicker selectedRowInComponent:0]];
    [self.currencyType resignFirstResponder];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Start out working with the test environment! When you are ready, switch to PayPalEnvironmentProduction.
    [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentNoNetwork];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)makePaymentClicked:(id)sender{
    // Create a PayPalPayment
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    
    // Amount, currency, and description
    payment.amount = [[NSDecimalNumber alloc] initWithString:_amount.text];
    payment.currencyCode = _currencyType.text;
    payment.shortDescription = _paymentDescription.text;
    
    // Use the intent property to indicate that this is a "sale" payment,
    // meaning combined Authorization + Capture.
    // To perform Authorization only, and defer Capture to your server,
    // use PayPalPaymentIntentAuthorize.
    // To place an Order, and defer both Authorization and Capture to
    // your server, use PayPalPaymentIntentOrder.
    // (PayPalPaymentIntentOrder is valid only for PayPal payments, not credit card payments.)
    payment.intent = PayPalPaymentIntentSale;
    
    // If your app collects Shipping Address information from the customer,
    // or already stores that information on your server, you may provide it here.
//    payment.shippingAddress = address; // a previously-created PayPalShippingAddress object
    
    // Several other optional fields that you can set here are documented in PayPalPayment.h,
    // including paymentDetails, items, invoiceNumber, custom, softDescriptor, etc.
    
    // Check whether payment is processable.
    if (!payment.processable) {
        NSLog(@"Sorry can't process the payment due to reason of either amount was negative or the shortDescription was empty");
        // If, for example, the amount was negative or the shortDescription was empty, then
        // this payment would not be processable. You would want to handle that here.
    } else{
    
        // Create a PayPalPaymentViewController.
        PayPalPaymentViewController *paymentViewController;
        paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                       configuration:self.payPalConfiguration
                                                                            delegate:self];
        
        // Present the PayPalPaymentViewController.
        [self presentViewController:paymentViewController animated:YES completion:nil];
    }
}

#pragma mark - PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController
                 didCompletePayment:(PayPalPayment *)completedPayment {
    // Payment was processed successfully; send to server for verification and fulfillment.
    [self verifyCompletedPayment:completedPayment];
    
    // Dismiss the PayPalPaymentViewController.
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    // The payment was canceled; dismiss the PayPalPaymentViewController.
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)verifyCompletedPayment:(PayPalPayment *)completedPayment {
    // Send the entire confirmation dictionary
    NSData *confirmation = [NSJSONSerialization dataWithJSONObject:completedPayment.confirmation
                                                           options:0
                                                             error:nil];
    NSLog(@"confirmation: %@", confirmation);
    // Send confirmation to your server; your server should verify the proof of payment
    // and give the user their goods or services. If the server is not reachable, save
    // the confirmation and try again later.
}

#pragma mark - pickerViewDelegates
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.currencyTypeArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.currencyTypeArray[row];
}

#pragma mark - textView delegates

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if([[textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@"Description about payment"]){
        textView.textColor = [UIColor blackColor];
        textView.text = @"";
    }
    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if([textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0){
        textView.text = @"Description about payment";
        textView.textColor = [UIColor lightGrayColor];
    }
    return YES;

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
