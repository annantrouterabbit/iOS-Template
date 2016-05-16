//
//  StripePaymentViewController.h
//  signinDemo
//
//  Created by Annant Gupta on 5/12/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormValidator.h"

@interface StripeCreateCardViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *createCardButton;
@property (weak, nonatomic) IBOutlet UITextField *expiryDate;
@property (weak, nonatomic) IBOutlet UITextField *cardHolderName;
@property (weak, nonatomic) IBOutlet UITextField *cardNumber;
@property (weak, nonatomic) IBOutlet UITextField *cardCVC;
@property int noOfTextFields;
- (IBAction)createCardClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property FormValidator *formValidator;

@end
