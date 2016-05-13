//
//  StripeHandler.m
//  signinDemo
//
//  Created by Annant Gupta on 5/12/16.
//  Copyright © 2016 Annant Gupta. All rights reserved.
//

#import "StripeHandler.h"

@implementation StripeHandler
//+(StripeHandler*)sharedHandler{
//    static StripeHandler *handler;
//    static dispatch_once_t *onceToken;
//    dispatch_once(onceToken, ^(void){
//        handler = [[StripeHandler alloc] init];
//    });
//    
//    
//    //another implementation
////    if(!handler){
////        handler = [[StripeHandler alloc] init];
////    }
//    
//    return handler;
//}

-(void)createCardTokenWithCardHolderName:(NSString *)cardHolderName cardNumber:(NSString *)cardNumber expiryMonth:(NSUInteger)expiryMonth expiryYear:(NSUInteger)expiryYear cardCVC:(NSString *)cardCVC{
    STPCardParams *cardData = [[STPCardParams alloc]init];
    cardData.name = cardHolderName;
    cardData.number = cardNumber;
    cardData.expMonth = expiryMonth;
    cardData.expYear = expiryYear;
    
    [[STPAPIClient sharedClient]
     createTokenWithCard:cardData
     completion:^(STPToken *token, NSError *error) {
         if (error) {
             [self.delegate didPaymentCompleted:NO data:(NSString *)error.localizedDescription];
//             NSLog(@"Stripe error for card token: %@", (NSString *)error.localizedDescription);
         } else {
//             [self createBackendChargeWithToken:token completion:^(PKPaymentAuthorizationStatus status) {
//                 ...
//             }];
             
             if([self.delegate conformsToProtocol:@protocol(StripeHandlerDelegate)]){
                 [self.delegate didPaymentCompleted:YES data:(NSString*)token];
             }
//             NSLog(@"Stripe token for card: %@", (NSString*)token);
         }
     }];
}

@end
