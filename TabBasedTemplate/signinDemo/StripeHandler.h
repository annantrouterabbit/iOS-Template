//
//  StripeHandler.h
//  signinDemo
//
//  Created by Annant Gupta on 5/12/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Stripe/Stripe.h>

#define STRIPE_DEV_APIKEY @"pk_test_glQTJ5GTeOFxZQFQSbXOzNtQ"
#define STRIPE_PROD_APIKEY @""

@protocol StripeHandlerDelegate <NSObject>

@required
-(void)didPaymentCompleted:(BOOL)success data:(NSString*)data;

@end

@interface StripeHandler : NSObject
@property id<StripeHandlerDelegate> delegate;
//+(StripeHandler*)sharedHandler;
-(void)createCardTokenWithCardHolderName:(NSString *)cardHolderName cardNumber:(NSString*)cardNumber expiryMonth:(NSUInteger)expiryMonth expiryYear:(NSUInteger)expiryYear cardCVC:(NSString*)cardCVC;
@end
