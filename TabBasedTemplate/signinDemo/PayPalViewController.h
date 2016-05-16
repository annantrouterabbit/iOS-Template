//
//  PayPalViewController.h
//  signinDemo
//
//  Created by Annant Gupta on 5/13/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormValidator.h"

@interface PayPalViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *makePaymentButton;

@property (weak, nonatomic) IBOutlet UITextField *amount;
@property int noOfTextFields;
- (IBAction)makePaymentClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *currencyType;
@property (weak, nonatomic) IBOutlet UITextView *paymentDescription;
@property FormValidator *formValidator;


@end
