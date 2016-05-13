//
//  FormValidator.h
//  FormValidation
//
//  Created by Annant Gupta on 5/11/16.
//  Copyright (c) 2016 Annant Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ValidationItem.h"
#import <SPXDataValidators/SPXRegexDataValidator.h>

typedef NS_ENUM(int, validatorTypes){
    kFormValidatorFirstName,
    kFormValidatorLastName,
    kFormValidatorEmail,
    kFormValidatorPassword,
    kFormValidatorBirthday,
    kFormValidatorLast4SSN,
    kFormValidatorStreet,
    kFormValidatorLocality,
    kFormValidatorRegion,
    kFormValidatorPostalCode,
    kFormValidatorCountry,
    kFormValidatorLegalBusinessName,
    kFormValidatorDBAName,
    kFormValidatorTaxId,
    kFormValidatorFundingType,
    kFormValidatorRoutingNumber,
    kFormValidatorAccountNumber,
    kFormValidatorAccountNumberMasked,
    kFormValidatorMobilePhone,
    kFormValidatorBio,
    kFormValidatorDescription,
    kFormValidatorDateTime,
    kFormValidatorListingType,
    kFormValidatorNonEmpty,
    kFormValidatorCatchAll,
    kFormValidatorCVC,
    kFormValidatorCardNumber
};

typedef NS_ENUM(int, validationResult) {
    kFormValidatorResultDefault,
    kFormValidatorResultValid,
    kFormValidatorResultInvalid
};

typedef void (^TooltipCompletion)(validationResult result);
typedef void (^TooltipFinished)();
typedef void (^InputValidationResult)(int idx, validationResult result);

@interface FormValidator : NSObject

@property UIImage *validImage;
@property UIImage *invalidImage;

+(SPXRegexDataValidator*)supportedValidatorForKey:(int)key;


//methods to initalize a form with a data model and to validate values against that model
-(instancetype)initWithFormInputs:(NSArray*)inputTypes; //think of this as the data model for the form
-(void)setFormInputs:(NSArray *)inputTypes;

-(void)addFormFieldWithType:(validatorTypes)type atIndex:(NSUInteger)index;
-(void)removeFormFieldAtIndex:(NSUInteger)index;

-(BOOL)validateFormWithInputValues:(NSArray *)inputValues inputStatus:(InputValidationResult)status; //checks input values against the validator model and calls a status block with the index and result from each field validation
-(BOOL)validateFormWithInputValues:(NSArray*)inputValues; //check the input values against the validator model
-(BOOL)validateFormInputAtIndex:(NSInteger)index withInputValues:(NSArray*)inputValues inputStatus:(InputValidationResult)status;

//methods to set special considerations for inputValidators
-(void)flagAsOptionalFormInputsAtIndexes:(NSIndexSet*)indexes;
-(void)flagAsRequiredFormInputsAtIndexes:(NSIndexSet*)indexes;
-(void)skipValidationOnFormInputsAtIndexes:(NSIndexSet*)indexes;
-(void)addRelationship:(validatorRelationshipTypes)type toValidationItemAtIndex:(NSUInteger)index dependentUponValidatonItemsAtIndexes:(NSIndexSet*)indexes;

//methods to present, update, and dismiss tooltips


//block-based
-(void)presentTooltipForFormInputAtIndex:(NSInteger)index forValue:(id)value withTargetView:(UIView*)targetView andWidth:(CGFloat)width completionHandler:(TooltipCompletion)completion;
-(void)updateTooltipForFormInputAtIndex:(NSInteger)index forValue:(id)value completionHandler:(TooltipCompletion)completion;
-(void)hideTooltipWithCompletionHandler:(TooltipFinished)completion;

//use in conjunction with special cases of validationItems
-(void)presentTooltipForFormInputAtIndex:(NSInteger)index forValues:(NSArray*)inputValues withTargetView:(UIView*)targetView andWidth:(CGFloat)width completionHandler:(TooltipCompletion)completion;
-(void)updateTooltipForFormInputAtIndex:(NSInteger)index forValues:(NSArray*)inputValues completionHandler:(TooltipCompletion)completion;


//regular
-(void)presentTooltipForFormInputAtIndex:(NSInteger)index forValue:(id)value withTargetView:(UIView*)targetView andWidth:(CGFloat)width;
-(void)updateTooltipForFormInputAtIndex:(NSInteger)index forValue:(id)value;
-(void)hideTooltip;

-(void)presentTooltipForFormInputAtIndex:(NSInteger)index forValues:(NSArray*)inputValues withTargetView:(UIView*)targetView andWidth:(CGFloat)width;
-(void)updateTooltipForFormInputAtIndex:(NSInteger)index forValues:(NSArray*)inputValues;


-(void)refreshTooltip;
-(void)redisplayTooltipInView:(UIView*)view;
@end
