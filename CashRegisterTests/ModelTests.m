//
//  ModelTests.m
//  CashRegister
//
//  Created by Douglas Patrick Caldwell on 9/13/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "ModelTests.h"
#import "Denomination.h"

@implementation ModelTests

- (void)testDenominationCreation
{
    Denomination *result = [Denomination fromName:@"ONE HUNDRED" andValue:[NSDecimalNumber decimalNumberWithString:@"100.00"]];
    STAssertEqualObjects(@"ONE HUNDRED", result.name, @"Should set name on denomination.");
    STAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@"100.00"], result.value, @"Should set value on denomination.");
    
    result = [Denomination fromName:@"FIFTY" andStringValue:@"50.00"];
    STAssertEqualObjects(@"FIFTY", result.name, @"Should set name on denomination.");
    STAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@"50.00"], result.value, @"Should set value on denomination.");    
}

@end
