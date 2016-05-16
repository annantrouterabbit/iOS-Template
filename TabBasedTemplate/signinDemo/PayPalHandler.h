//
//  PayPalHandler.h
//  signinDemo
//
//  Created by Annant Gupta on 5/13/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#define PAYPAL_DEV_APIKEY @"AVSdqI-XCeLI6aQHLQX2Z2c83yyfoYmKna1ZY9dTqO9Z17UvGUcsGPNya35s8F3PtYRm8I_byG3ARc3a"
#define PAYPAL_PROD_APIKEY @"AX1RbYEU3fEQ0HV07TpO0_7__eY8MSooOtfYmkZ3kGmTnddR8OOGOg38_IP0NdQyg_RCCPrmPB3b8gub"

@protocol PayPalHandlerDelegate <NSObject>
@required

-(void)didCardCreated:(BOOL)success;

@end
@interface PayPalHandler : NSObject

@property id<PayPalHandlerDelegate> delegate;
-(void)createCardTokenWithCardHolderName:(NSString *)cardHolderName cardNumber:(NSString*)cardNumber expiryMonth:(NSUInteger)expiryMonth expiryYear:(NSUInteger)expiryYear cardCVC:(NSString*)cardCVC;

@end
