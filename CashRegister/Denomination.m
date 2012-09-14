//
//  Denomination.m
//  CashRegister
//
//  Created by Douglas Patrick Caldwell on 9/13/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "Denomination.h"

@implementation Denomination

@synthesize value;
@synthesize name;

+(Denomination *)fromName:(NSString *)name andValue:(NSDecimalNumber *)value
{
    Denomination *result = [Denomination new];
    
    result.value = value;
    result.name = name;
    
    return result;
}

+(Denomination *)fromName:(NSString *)name andStringValue:(NSString *)value
{
    NSDecimalNumber *decimal = [NSDecimalNumber decimalNumberWithString:value];
    return [[self class] fromName:name andValue:decimal];
}

@end
