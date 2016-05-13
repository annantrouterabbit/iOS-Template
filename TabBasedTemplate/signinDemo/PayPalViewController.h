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
@property (weak, nonatomic) IBOutlet UITextField *expiryDate;
@property (weak, nonatomic) IBOutlet UITextField *cardHolderName;
@property (weak, nonatomic) IBOutlet UITextField *cardNumber;
@property (weak, nonatomic) IBOutlet UITextField *cardCVC;
@property int noOfTextFields;
- (IBAction)makePaymentClicked:(id)sender;
@property FormValidator *formValidator;


@end
