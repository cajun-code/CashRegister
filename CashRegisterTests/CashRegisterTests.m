//
//  CashRegisterTests.m
//  CashRegisterTests
//
//  Created by Allan Davis on 8/22/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "CashRegisterTests.h"
#import "ChangeDispenser.h"

@implementation CashRegisterTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testChangeDespenserReturnsMagicStringError
{
    static NSString *desiredResult = @"ERROR";
    
    NSString *result;
    result = [ChangeDispenser dispenseChangeFor:[NSDecimalNumber maximumDecimalNumber] withCash:[NSDecimalNumber minimumDecimalNumber]];

    STAssertEquals(result, desiredResult, @"If cash is less than price, Change Dispenser returns 'ERROR.'");
}

- (void)testChangeDespenserReturnsMagicStringZero
{
    static NSString *desiredResult = @"ZERO";
    
    NSString *result;
    result = [ChangeDispenser dispenseChangeFor:[NSDecimalNumber zero]  withCash:[NSDecimalNumber zero]];
    
    STAssertEquals(result, desiredResult, @"If cash is equal to price, Change Dispenser returns 'ZERO.'");
}

- (void)testChangeDespenserReturnsChangeString
{
    
}

@end
