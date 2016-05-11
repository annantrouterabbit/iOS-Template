//
//  ValidationItem.m
//  FormValidation
//
//  Created by Annant Gupta on 5/11/16.
//  Copyright (c) 2016 Annant Gupta. All rights reserved.
//

#import "ValidationItem.h"

@implementation ValidationItem

+(instancetype)validationItemWithItem:(ValidationItem *)item{
    ValidationItem *newItem = [[ValidationItem alloc]init];
    newItem.validator = item.validator;
    newItem.regex = item.regex;
    newItem.defaultMessage = item.defaultMessage;
    newItem.validMessage = item.validMessage;
    newItem.invalidMessage = item.invalidMessage;
    NSLog(@"%@", newItem);
    return newItem;
}

-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        _isOptional = NO;
        _skipValidation = NO;
        _relationships = [[NSMutableDictionary alloc]init];
    }
    
    return self;

}


-(BOOL)validateValue:(id)value error:(NSError *)error{
    if (self.skipValidation) {
        return YES;
    }
    
    if ([value length] <= 0 && self.isOptional) {
        return YES;
    }
    
    return [self.validator validateValue:value error:nil];



}

-(id)copyWithZone:(NSZone *)zone{
    id copy = [[[self class] alloc]init];
    
    if (copy) {
        SPXRegexDataValidator *validator = [[SPXRegexDataValidator alloc]init];
        validator.regexPattern = self.regex;
        
        [copy setRegex:[self.regex copyWithZone:zone]];
        [copy setValidator:validator];
        [copy setDefaultMessage:[self.defaultMessage copyWithZone:zone]];
        [copy setValidMessage:[self.validMessage copyWithZone:zone]];
        [copy setInvalidMessage:[self.invalidMessage copyWithZone:zone]];
        [copy setIsOptional:NO];
        [copy setSkipValidation:NO];
        
    }
    
    return copy;
}

-(void)addRelationship:(validatorRelationshipTypes)type otherAtIndex:(NSUInteger)index{
     NSNumber *relationshipTypeWrapper = [NSNumber numberWithInt:type];
     NSNumber *indexOfOtherWrapper = [NSNumber numberWithInt:(int)index];
    
    if ([self.relationships objectForKey:relationshipTypeWrapper]) {
        [[self.relationships objectForKey:relationshipTypeWrapper]addObject:indexOfOtherWrapper];
    }else{
        NSMutableArray *relationshipArray = [[NSMutableArray alloc]init];
        [relationshipArray addObject:indexOfOtherWrapper];
        [self.relationships setObject:relationshipArray forKey:relationshipTypeWrapper];
    }
}

-(BOOL)validateValue:(id)value dependentUpon:(ValidationItem *)item withValue:(id)dependencyValue error:(NSError *)error{
    
    if ([item validateValue:dependencyValue error:nil] && [self validateValue:value error:nil]) {
        return YES;
    }else{
        return NO;
    }

}

-(BOOL)validateValue:(id)value bothOrNeither:(ValidationItem *)item withValue:(id)dependencyValue error:(NSError *)error{
    
    if ((self.isOptional && item.isOptional) && ([value length]<= 0 && [dependencyValue length] <=0)) {
        return YES;
    }
    
    if (([value length] > 0 && [dependencyValue length] > 0) && [self validateValue:value error:nil] && [item validateValue:dependencyValue error:nil]) {
        return YES;
    }
    
    return NO;

}

-(BOOL)validateValue:(id)value equalTo:(ValidationItem*)item withValue:(id)dependencyValue error:(NSError*)error{
    if([value isEqual:dependencyValue]){
        return YES;
    }
    
    return NO;

}


@end
