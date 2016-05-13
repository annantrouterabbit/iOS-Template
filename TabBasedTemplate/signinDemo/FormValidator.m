//
//  FormValidator.m
//  FormValidation
//
//  Created by Annant Gupta on 5/11/16.
//  Copyright (c) 2016 Annant Gupta. All rights reserved.
//

#import "FormValidator.h"
#import <JDFTooltips/JDFTooltips.h>
#import <SPXDataValidators/SPXDataValidator.h>
#import <SPXDataValidators/SPXFormValidator.h>
#import <SPXDataValidators/SPXNonEmptyDataValidator.h>

static NSString *firstNameRegex = @"^[A-Za-z -]{2,20}$";
static NSString *lastNameRegex = @"^[A-Za-z' -]{2,20}$";
static NSString *passwordRegex = @"^[A-Za-z0-9!#%\\&'*+=?\\^_`{|}~$-]{5,}$";
static NSString *birthdayRegex = @"^(19|20)\\d\\d-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$";
static NSString *last4SSNRegex = @"^[0-9]{4}$";
static NSString *streetRegex = @"^[A-Za-z0-9'.#, -]{2,}$";//@"^([A-Za-z0-9'.#, -]|\\u2013){2,}$";
static NSString *cvc = @"^[0-9]{3}$";
static NSString *localityRegex = @"^[A-Za-z0-9'. -]{2,}$";
static NSString *regionRegex = @"^[A-Za-z]{2}$";
static NSString *postalCodeRegex= @"^\\d{5}$";
static NSString *countryRegex = @"^US$";
static NSString *legalNameRegex = @"^[A-Za-z0-9\\$&!@#()'\\.\\/+,\" -]{2,40}$";
static NSString *dbaNameRegex = @"^[A-Za-z0-9\\$&!@#()'\\.\\/+,\" -]{2,40}$";
static NSString *taxIdRegex = @"^[0-9]{9}$";
static NSString *fundingTypeRegex = @"^(Bank|Email|Mobile Phone)$";
static NSString *routingNumberRegex = @"^[0-9]{9}$";
static NSString *accountNumberRegex = @"^[0-9]{8,16}$";
static NSString *accountNumberMaskedRegex = @"^[0-9*]{8,16}$";
static NSString *mobilePhoneRegex = @"^(([0-9][\\. -])*(\\([0-9]{3}\\)|[0-9]{3})[\\. -][0-9]{3}[\\. -][0-9]{4}$|[0-9]{10,11}$)$";
static NSString *bioRegex = @"^[A-Za-z0-9!:#%;,\\&\\.'*+\\/=?\\^_`{|}~$()\"\\\\\\t\\s\\n -]{1,140}$";
static NSString *descriptionRegex = @"^[A-Za-z0-9!:#%;,\\&\\.'*+\\/=?\\^_`{|}~$()\"\\\\\\t\\s\\n -]{1,140}$";
static NSString *datetimeRegex = @"^(0[1-9]|1[012])-([012][0-9]|3[012])-2[0-9]{3}, ((0[1-9]|1[012])|(0[1-9]|1[1-9]|2[0123])):[0-5][0-9]\\s*(am|pm)*$";
static NSString *listingType = @"^Product\\/Service$";
static NSString *nonEmptyRegex = @"^[A-Za-z0-9!:#%;,\\&\\.'*+\\/=?\\^_`{|}~$()\"\\\\\\t\\s -]+$";
static NSString *catchAllRegex = @"^[A-Za-z0-9!:#%;,\\&\\.'*+\\/=?\\^_`{|}~$()\"\\\\\\t\\s -]*$";
static NSString *cardNumber = @"^[0-9]{16}";

@interface FormValidator()

@property JDFTooltipView *tooltip;
@property NSMutableArray *inputValidators;
@end

@implementation FormValidator


/*------------Class Methods/Data Methods---------*/
+(NSArray *)validators{
    static NSArray *validators = nil;
    if (validators == nil) {
        validators = @[[SPXRegexDataValidator validatorWithExpression:firstNameRegex],
                       [SPXRegexDataValidator validatorWithExpression:lastNameRegex],
                       [SPXEmailDataValidator new],
                       [SPXRegexDataValidator validatorWithExpression:passwordRegex],
                       [SPXRegexDataValidator validatorWithExpression:birthdayRegex],
                       [SPXRegexDataValidator validatorWithExpression:last4SSNRegex],
                       [SPXRegexDataValidator validatorWithExpression:streetRegex],
                       [SPXRegexDataValidator validatorWithExpression:localityRegex],
                       [SPXRegexDataValidator validatorWithExpression:regionRegex],
                       [SPXRegexDataValidator validatorWithExpression:postalCodeRegex],
                       [SPXRegexDataValidator validatorWithExpression:countryRegex],
                       [SPXRegexDataValidator validatorWithExpression:legalNameRegex],
                       [SPXRegexDataValidator validatorWithExpression:dbaNameRegex],
                       [SPXRegexDataValidator validatorWithExpression:taxIdRegex],
                       [SPXRegexDataValidator validatorWithExpression:fundingTypeRegex],
                       [SPXRegexDataValidator validatorWithExpression:routingNumberRegex],
                       [SPXRegexDataValidator validatorWithExpression:accountNumberRegex],
                       [SPXRegexDataValidator validatorWithExpression:accountNumberMaskedRegex],
                       [SPXRegexDataValidator validatorWithExpression:mobilePhoneRegex],
                       [SPXRegexDataValidator validatorWithExpression:bioRegex],
                       [SPXRegexDataValidator validatorWithExpression:descriptionRegex],
                       [SPXRegexDataValidator validatorWithExpression:datetimeRegex],
                       [SPXRegexDataValidator validatorWithExpression:listingType],
                       [SPXRegexDataValidator validatorWithExpression:nonEmptyRegex],
                       [SPXRegexDataValidator validatorWithExpression:catchAllRegex],
                       [SPXRegexDataValidator validatorWithExpression:cvc],
                       [SPXRegexDataValidator validatorWithExpression:cardNumber]
                       ];
    }
    return validators;
}

+(NSArray *)defaultMessages{
    static NSArray *defaultMessages = nil;
    if (defaultMessages == nil) {
        defaultMessages = @[@"Enter your first name",
                            @"Enter your last Name",
                            @"Enter your email address",
                            @"Enter a password",
                            @"Enter your birthday",
                            @"",
                            @"Enter your street address",
                            @"Enter your city",
                            @"Enter your 2-digit state abbreviation",
                            @"Enter your 5-digit postal code",
                            @"",
                            @"Enter your legal business name (optional)",
                            @"Enter your business' trade name",
                            @"Enter your business' tax id (optional)",
                            @"Enter a supported funding type",
                            @"Enter your routing number",
                            @"Enter your account number",
                            @"Enter your account number",
                            @"Enter your mobile phone number",
                            @"Enter a brief description",
                            @"Enter a brief description",
                            @"Enter a valid date and time",
                            @"Choose a listing type",
                            @"Enter anything",
                            @"Catch all",
                            @"Enter 3 digits in CVC",
                            @"Enter 16 digits card number"
                            ];
    }
    return defaultMessages;
}

+(NSArray *)validMessages{
    static NSArray *validMessages = nil;
    if (validMessages == nil) {
        validMessages = @[@"First name is valid",
                          @"Last name is valid",
                          @"Email is valid",
                          @"Password is valid",
                          @"Birthday is valid",
                          @"",
                          @"Street Address is valid",
                          @"City is valid",
                          @"State Abbreviation is valid",
                          @"Postal Code is valid",
                          @"",
                          @"Business legal name is valid",
                          @"Trade (DBA) name is valid",
                          @"Tax id is valid",
                          @"Funding type is valid",
                          @"Routing number is valid",
                          @"Account number is valid",
                          @"Account number is valid",
                          @"Mobile phone number is valid",
                          @"Bio is valid",
                          @"Description is valid",
                          @"Date and time are valid",
                          @"Listing type is valid",
                          @"This field is valid",
                          @"Catch all is valid",
                          @"CVC is valid",
                          @"Card number is valid"
                          ];
    }
    return validMessages;
}

+(NSArray *)invalidMessages{
    static NSArray *invalidMessages = nil;
    if (invalidMessages == nil) {
        invalidMessages = @[@"You first name should be between 2-20 alphabetical characters",
                          @"You first name should be between 2-20 alphabetical characters",
                          @"Your email must follow a format similar to name@example.com",
                          @"Your password must be at least five characters in length.",
                          @"Birthdays must follow the format YYYY-MM-DD",
                          @"",
                          @"Street addresses must contain at least two characters",
                          @"City must contain at least two characters",
                          @"State must be a valid 2-digit state abbreviation",
                          @"Postal Code must be a valid 5-digit postal code",
                          @"",
                          @"Business Legal Name must contain between 2-40 characters(optional). If provided, requires valid tax id.",
                          @"Trade/DBA Name must contain between 2-40 characters, if provided",
                          @"Tax id must contain exactly 9 digits(optional). If provided, requires valid Legal Name.",
                          @"Funding types supported are 'Bank', 'Email', and 'Mobile Phone'",
                          @"Routing number",
                          @"Account number",
                          @"Account number",
                          @"Mobile phone number",
                          @"Bio",
                          @"Description",
                          @"Date and time",
                          @"Listing Type must be a provided value",
                          @"This field cannot be left blank",
                          @"Catch all can't be invalid",
                            @"CVC should contains 3 digits",
                            @"Card number should contains 16 digits between 0-9"
                          ];
    }
    return invalidMessages;
}

+(NSArray *)supportedValidators{
    static NSArray *supportedValidators = nil;
    if (supportedValidators == nil) {
        NSMutableArray *supportedValidatorsMut = [[NSMutableArray alloc]init];
        
        NSArray *validators = [FormValidator validators];
        NSArray *defaultMessages = [FormValidator defaultMessages];
        NSArray *validMessages = [FormValidator validMessages];
        NSArray *invalidMessages = [FormValidator invalidMessages];
        
        for (int i = 0; i < [validators count]; i++) {
            ValidationItem *validationItem = [[ValidationItem alloc]init];
            SPXRegexDataValidator *validator = (SPXRegexDataValidator*)[validators objectAtIndex:i];
            validationItem.validator = validator;
            validationItem.regex = validator.regexPattern;
            validationItem.defaultMessage = [defaultMessages objectAtIndex:i];
            validationItem.validMessage = [validMessages objectAtIndex:i];
            validationItem.invalidMessage = [invalidMessages objectAtIndex:i];
            [supportedValidatorsMut insertObject:validationItem atIndex:i];
        }
        
        supportedValidators = [NSArray arrayWithArray:supportedValidatorsMut];
    }
    return supportedValidators;
}

+(SPXRegexDataValidator*)supportedValidatorForKey:(int)key{
    ValidationItem *validationItem = (ValidationItem*)[[FormValidator supportedValidators]objectAtIndex:key];
    return validationItem.validator;
}


/*-----------Instance Methods--------------*/
#pragma initializer

-(instancetype)init{
    self = [super init];
    
    if (self) {
        _validImage = [UIImage imageNamed:@"checkmark"];
        _invalidImage = [UIImage imageNamed:@"error"];
    }
    return self;
}

-(instancetype)initWithFormInputs:(NSArray*)inputTypes{
    FormValidator *formValidator = [[FormValidator alloc]init];
    NSMutableArray *inputValidatorsMut = [[NSMutableArray alloc]init];
    NSArray *supportedValidators = [FormValidator supportedValidators];
    
    for (int i = 0; i < [inputTypes count]; i++) {
        validatorTypes type = [[inputTypes objectAtIndex:i]intValue];
        //ValidationItem *item = [ValidationItem validationItemWithItem:[supportedValidators objectAtIndex:type]];
        ValidationItem *item = [[supportedValidators objectAtIndex:type]copyWithZone:nil];
        [inputValidatorsMut addObject:item];
    }
    formValidator.inputValidators = inputValidatorsMut;
    return formValidator;
}

-(void)setFormInputs:(NSArray *)inputTypes{
    NSMutableArray *inputValidatorsMut = [[NSMutableArray alloc]init];
    NSArray *supportedValidators = [FormValidator supportedValidators];
    
    for (int i = 0; i < [inputTypes count]; i++) {
        validatorTypes type = [[inputTypes objectAtIndex:i]intValue];
        //ValidationItem *item = [ValidationItem validationItemWithItem:[supportedValidators objectAtIndex:type]];
        ValidationItem *item = [[supportedValidators objectAtIndex:type]copyWithZone:nil];
        [inputValidatorsMut addObject:item];
    }
    self.inputValidators = inputValidatorsMut;

}

-(void)addFormFieldWithType:(validatorTypes)type atIndex:(NSUInteger)index{
    ValidationItem *item = [[[FormValidator supportedValidators] objectAtIndex:type]copyWithZone:nil];
    [self.inputValidators insertObject:item atIndex:index];
}
-(void)removeFormFieldAtIndex:(NSUInteger)index{
    [self.inputValidators removeObjectAtIndex:index];

}
#pragma validation methods

-(BOOL)validateFormWithInputValues:(NSArray *)inputValues inputStatus:(InputValidationResult)status{
    if ([inputValues count] != [self.inputValidators count]) {
        //user error here; there should be a one-to-one mapping for values to validators
        return NO;
    }
    
    BOOL isValid = YES;
    for (int i = 0; i < [self.inputValidators count]; i++) {
       
        ValidationItem *validationItem = [self.inputValidators objectAtIndex:i];
        if ([self validateItem:validationItem atIndex:i withInputValues:inputValues] != YES) {
            if (status) {
                if ([[inputValues objectAtIndex:i]length] <=0) {
                    status(i, kFormValidatorResultDefault);
                }else{
                    status(i, kFormValidatorResultInvalid);
                }
            }
            isValid = NO;
        }else{
            if (status) {
                if ([[inputValues objectAtIndex:i]length] <=0) {
                    status(i, kFormValidatorResultDefault);
                }else{
                    status(i, kFormValidatorResultValid);
                }
            }
        }
    }
    return isValid;
}

-(BOOL)validateFormWithInputValues:(NSArray *)inputValues{
    if ([inputValues count] != [self.inputValidators count]) {
        return NO;
    }
    
    for (int i = 0; i < [self.inputValidators count]; i++) {
        ValidationItem *validationItem = [self.inputValidators objectAtIndex:i];
        if ([self validateItem:validationItem atIndex:i withInputValues:inputValues] != YES) {
            return NO;
        }
    }
    
    return YES;
    
}

-(BOOL)validateItem:(ValidationItem*)item atIndex:(NSUInteger)index withInputValues:(NSArray*)inputValues{
    
    NSDictionary *relationshipsDict = item.relationships;
    NSArray *relationships = [relationshipsDict allKeys];
    id valueOfItem = [inputValues objectAtIndex:index];
    
    if ([relationships count] > 0) {
        for (int i = 0; i < [relationships count]; i++) {
            NSNumber *relationshipType = [relationships objectAtIndex:i];
            NSArray *others = [relationshipsDict objectForKey:relationshipType];
            
            for (int j = 0; j < [others count]; j++) {
                int indexOfOther = [[others objectAtIndex:j] intValue];
                ValidationItem *other = [self.inputValidators objectAtIndex:indexOfOther];
                id valueOfOther = [inputValues objectAtIndex:indexOfOther];
                
                if ([self resolveRelationshipWithType:[relationshipType intValue] targetItem:item withValue:valueOfItem otherItem:other withValue:valueOfOther] != YES) {
                    return NO;
                }
            }
        }
        
        return YES;
    }else{
        return [item validateValue: [inputValues objectAtIndex:index] error:nil];

    }

}

-(BOOL)validateFormInputAtIndex:(NSInteger)index withInputValues:(NSArray*)inputValues inputStatus:(InputValidationResult)status{
    ValidationItem *item = [self.inputValidators objectAtIndex:index];
    NSDictionary *relationshipsDict = item.relationships;
    NSArray *relationships = [relationshipsDict allKeys];
    id valueOfItem = [inputValues objectAtIndex:index];
    
    
    if ([relationships count] > 0) {
        for (int i = 0; i < [relationships count]; i++) {
            NSNumber *relationshipType = [relationships objectAtIndex:i];
            NSArray *others = [relationshipsDict objectForKey:relationshipType];
            
            for (int j = 0; j < [others count]; j++) {
                int indexOfOther = [[others objectAtIndex:j] intValue];
                ValidationItem *other = [self.inputValidators objectAtIndex:indexOfOther];
                id valueOfOther = [inputValues objectAtIndex:indexOfOther];
                
                if ([self resolveRelationshipWithType:[relationshipType intValue] targetItem:item withValue:valueOfItem otherItem:other withValue:valueOfOther] != YES) {
                    status((int)index, kFormValidatorResultInvalid);
                    return NO;
                }
            }
        }
        
        return YES;
    }else{
        
        if ([valueOfItem length] <= 0) {
            status((int)index, kFormValidatorResultDefault);
            return item.isOptional;
        }
        
        if ([item validateValue: [inputValues objectAtIndex:index] error:nil]){
            status((int)index, kFormValidatorResultValid);
            return YES;
        }else{
            status((int)index, kFormValidatorResultInvalid);
            return NO;
        }
        
    }
    
}

-(BOOL)resolveRelationshipWithType:(validatorRelationshipTypes)type targetItem:(ValidationItem*)targetItem withValue:(id)value otherItem:(ValidationItem*)other withValue:(id)dependencyValue{
    
    switch (type) {
        case kFormValidatorRelationshipDependentUpon:
            return [targetItem validateValue:value dependentUpon:other withValue:dependencyValue error:nil];
            break;
        
        case kFormValidatorRelationshipBothOrNeither:
            return [targetItem validateValue:value bothOrNeither:other withValue:dependencyValue error:nil];
            break;
        
        case kFormValidatorRelationshipEqual:
            return [targetItem validateValue:value equalTo:other withValue:dependencyValue error:nil];
        default:
            break;
    }
    
    return NO;
}



#pragma validationItem interfaces
-(void)flagAsOptionalFormInputsAtIndexes:(NSIndexSet*)indexes{
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [[self.inputValidators objectAtIndex:idx] setIsOptional:YES];
    }];

}

-(void)flagAsRequiredFormInputsAtIndexes:(NSIndexSet*)indexes{
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [[self.inputValidators objectAtIndex:idx] setIsOptional:NO];
    }];
}

-(void)skipValidationOnFormInputsAtIndexes:(NSIndexSet*)indexes{
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [[self.inputValidators objectAtIndex:idx] setSkipValidation:YES];
    }];
}

-(void)addRelationship:(validatorRelationshipTypes)type toValidationItemAtIndex:(NSUInteger)index dependentUponValidatonItemsAtIndexes:(NSIndexSet *)indexes{
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [[self.inputValidators objectAtIndex:index] addRelationship:type otherAtIndex:idx];
    }];
}

#pragma tooltip methods

//block-based
-(void)presentTooltipForFormInputAtIndex:(NSInteger)index forValue:(id)value withTargetView:(UIView *)targetView andWidth:(CGFloat)width completionHandler:(TooltipCompletion)completion{
    
    ValidationItem *validationItem = [self.inputValidators objectAtIndex:index];
    
    JDFTooltipView *tooltip = [[JDFTooltipView alloc]initWithTargetView:targetView hostView:[UIApplication sharedApplication].keyWindow tooltipText:nil arrowDirection:JDFTooltipViewArrowDirectionDown width:width];
    [tooltip sizeToFit];
    
    self.tooltip = tooltip;
    
    if ([value length] <= 0 ) {
        self.tooltip.tooltipBackgroundColour = [UIColor grayColor];
        self.tooltip.tooltipText = validationItem.defaultMessage;
        [self.tooltip setNeedsDisplay];
        
        if (completion) {
            completion(kFormValidatorResultDefault);
        }
        
        
    }else{
        
        BOOL isValid = [validationItem validateValue:value error:nil];
        
        if (isValid) {
            self.tooltip.tooltipBackgroundColour = [UIColor grayColor];
            self.tooltip.tooltipText = validationItem.validMessage;
            [self.tooltip setNeedsDisplay];
            
            if (completion) {
                completion(kFormValidatorResultValid);
            }
        }else{
            self.tooltip.tooltipBackgroundColour = [UIColor redColor];
            self.tooltip.tooltipText = validationItem.invalidMessage;
            [self.tooltip setNeedsDisplay];
            
            if (completion) {
                completion(kFormValidatorResultInvalid);
            }
        }
        
        
        
    }
    
    [self.tooltip show];

}


-(void)updateTooltipForFormInputAtIndex:(NSInteger)index forValue:(id)value completionHandler:(TooltipCompletion)completion{
    
    ValidationItem *validationItem = [self.inputValidators objectAtIndex:index];
    
    if ([value length] <= 0) {
        self.tooltip.tooltipBackgroundColour = [UIColor grayColor];
        self.tooltip.tooltipText = validationItem.defaultMessage;
        [self.tooltip sizeToFit];
        [self.tooltip hideAnimated:NO];
        [self.tooltip show];
        [self.tooltip setNeedsDisplay];
        if (completion) {
            completion(kFormValidatorResultDefault);
        }
        
    }else{
        BOOL isValid = [validationItem validateValue:value error:nil];
        
        if(isValid){
            self.tooltip.tooltipBackgroundColour = [UIColor grayColor];
            self.tooltip.tooltipText = validationItem.validMessage;
        }else{
            self.tooltip.tooltipBackgroundColour = [UIColor redColor];
            self.tooltip.tooltipText = validationItem.invalidMessage;
        }
        
        [self.tooltip sizeToFit];
        [self.tooltip hideAnimated:NO];
        [self.tooltip show];
        [self.tooltip setNeedsDisplay];
        
        if (completion) {
            if (isValid)
                completion(kFormValidatorResultValid);
            else
                completion(kFormValidatorResultInvalid);
        }
    }


}

-(void)hideTooltipWithCompletionHandler:(TooltipFinished)completion{
    [self.tooltip hideAnimated:NO];
    
    if (completion) {
        completion();
    }

}



-(void)presentTooltipForFormInputAtIndex:(NSInteger)index forValues:(NSArray *)inputValues withTargetView:(UIView *)targetView andWidth:(CGFloat)width completionHandler:(TooltipCompletion)completion{
    ValidationItem *validationItem = [self.inputValidators objectAtIndex:index];
    id value = [inputValues objectAtIndex:index];
    
    JDFTooltipView *tooltip = [[JDFTooltipView alloc]initWithTargetView:targetView hostView:[UIApplication sharedApplication].keyWindow tooltipText:nil arrowDirection:JDFTooltipViewArrowDirectionDown width:width];
    [tooltip sizeToFit];
    
    self.tooltip = tooltip;
    
    if ([value length] <= 0 ) {
        self.tooltip.tooltipBackgroundColour = [UIColor grayColor];
        self.tooltip.tooltipText = validationItem.defaultMessage;
        [self.tooltip setNeedsDisplay];
        
        if (completion) {
            completion(kFormValidatorResultDefault);
        }
        
        
    }else{
        
        BOOL isValid = [self validateItem:validationItem atIndex:index withInputValues:inputValues];
        
        if (isValid) {
            self.tooltip.tooltipBackgroundColour = [UIColor grayColor];
            self.tooltip.tooltipText = validationItem.validMessage;
            [self.tooltip setNeedsDisplay];
            
            if (completion) {
                completion(kFormValidatorResultValid);
            }
        }else{
            self.tooltip.tooltipBackgroundColour = [UIColor redColor];
            self.tooltip.tooltipText = validationItem.invalidMessage;
            [self.tooltip setNeedsDisplay];
            
            if (completion) {
                completion(kFormValidatorResultInvalid);
            }
        }
        
        
        
    }
    
    [self.tooltip show];

}


-(void)updateTooltipForFormInputAtIndex:(NSInteger)index forValues:(NSArray *)inputValues completionHandler:(TooltipCompletion)completion{
    
    ValidationItem *validationItem = [self.inputValidators objectAtIndex:index];
    id value = [inputValues objectAtIndex:index];
    
    if ([value length] <= 0) {
        self.tooltip.tooltipBackgroundColour = [UIColor grayColor];
        self.tooltip.tooltipText = validationItem.defaultMessage;
        [self.tooltip sizeToFit];
        [self.tooltip hideAnimated:NO];
        [self.tooltip show];
        [self.tooltip setNeedsDisplay];
        if (completion) {
            completion(kFormValidatorResultDefault);
        }
        
    }else{
        BOOL isValid = [self validateItem:validationItem atIndex:index withInputValues:inputValues];
        
        if(isValid){
            self.tooltip.tooltipBackgroundColour = [UIColor grayColor];
            self.tooltip.tooltipText = validationItem.validMessage;
        }else{
            self.tooltip.tooltipBackgroundColour = [UIColor redColor];
            self.tooltip.tooltipText = validationItem.invalidMessage;
        }
        
        [self.tooltip sizeToFit];
        [self.tooltip hideAnimated:NO];
        [self.tooltip show];
        [self.tooltip setNeedsDisplay];
        
        if (completion) {
            if (isValid)
                completion(kFormValidatorResultValid);
            else
                completion(kFormValidatorResultInvalid);
        }
    }

}

//regular methods
-(void)presentTooltipForFormInputAtIndex:(NSInteger)index forValue:(id)value withTargetView:(UIView *)targetView andWidth:(CGFloat)width{
    
    [self presentTooltipForFormInputAtIndex:index forValue:value withTargetView:targetView andWidth:width completionHandler:nil];
}

-(void)updateTooltipForFormInputAtIndex:(NSInteger)index forValue:(id)value{
    [self updateTooltipForFormInputAtIndex:index forValue:value completionHandler:nil];

}

-(void)hideTooltip{
    [self hideTooltipWithCompletionHandler:nil];
}


-(void)presentTooltipForFormInputAtIndex:(NSInteger)index forValues:(NSArray*)inputValues withTargetView:(UIView*)targetView andWidth:(CGFloat)width{
    [self presentTooltipForFormInputAtIndex:index forValues:inputValues withTargetView:targetView andWidth:width completionHandler:nil];

}

-(void)updateTooltipForFormInputAtIndex:(NSInteger)index forValues:(NSArray*)inputValues{
    [self updateTooltipForFormInputAtIndex:index forValues:inputValues completionHandler:nil];
}


-(void)refreshTooltip{
    [self.tooltip setTooltipNeedsLayoutWithHostViewSize:[UIApplication sharedApplication].keyWindow.frame.size];
}

-(void)redisplayTooltipInView:(UIView*)view{
    [self.tooltip showInView:view];
}



































@end
