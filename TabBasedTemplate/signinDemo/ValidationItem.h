//
//  ValidationItem.h
//  FormValidation
//
//  Created by Annant Gupta on 5/11/16.
//  Copyright (c) 2016 Annant Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SPXDataValidators/SPXRegexDataValidator.h>

typedef NS_ENUM(int, validatorRelationshipTypes) {
    kFormValidatorRelationshipDependentUpon,
    kFormValidatorRelationshipBothOrNeither,
    kFormValidatorRelationshipEqual,
};

@interface ValidationItem : NSObject <NSCopying>
@property SPXRegexDataValidator *validator;
@property NSString *regex;
@property NSString *defaultMessage;
@property NSString *validMessage;
@property NSString *invalidMessage;
@property BOOL isOptional;
@property BOOL skipValidation;
@property NSMutableDictionary *relationships;

+(instancetype)validationItemWithItem:(ValidationItem*)item;
-(BOOL)validateValue:(id)value error:(NSError *)error;


-(void)addRelationship:(validatorRelationshipTypes)type otherAtIndex:(NSUInteger)index;

//relationship handlers- return BOOL to indicate whether a relationship between two validation items passes the given test

//returns true if both the dependency evaluates to YES and the caller evaluates to YES, otherwise returns NO
-(BOOL)validateValue:(id)value dependentUpon:(ValidationItem*)item withValue:(id)dependencyValue error:(NSError*)error;

//returns YES if both items have valid values and are non-empty or both are items empty and optional; otherwise, returns NO
-(BOOL)validateValue:(id)value bothOrNeither:(ValidationItem*)item withValue:(id)dependencyValue error:(NSError*)error;

//returns YES if both items have valid values that are equal to each other and are non-empty
-(BOOL)validateValue:(id)value equalTo:(ValidationItem*)item withValue:(id)dependencyValue error:(NSError*)error;

@end
