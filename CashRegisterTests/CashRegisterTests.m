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
    result = [ChangeDispenser dispenseChangeForPrice:[NSDecimalNumber maximumDecimalNumber] withCash:[NSDecimalNumber zero]];

    STAssertEqualObjects(result, desiredResult, @"If cash is less than price, Change Dispenser returns 'ERROR.'");
}

- (void)testChangeDespenserReturnsMagicStringZero
{
    static NSString *desiredResult = @"ZERO";
    
    NSString *result;
    result = [ChangeDispenser dispenseChangeForPrice:[NSDecimalNumber zero]  withCash:[NSDecimalNumber zero]];
    
    STAssertEqualObjects(result, desiredResult, @"If cash is equal to price, Change Dispenser returns 'ZERO.'");
}

- (void)testChangeDespenserReturnsChangeString
{
    NSString *result;

    result = [ChangeDispenser dispenseChangeForPrice:[NSDecimalNumber zero] withCash:[NSDecimalNumber decimalNumberWithString:@".0199999"]];
    STAssertEqualObjects(result, @"PENNY", @"ZERO from .01 should result in one penny change");
    
    result = [ChangeDispenser dispenseChangeForPrice:[NSDecimalNumber decimalNumberWithString:@".42"] withCash:[NSDecimalNumber decimalNumberWithString:@".50"]];
    STAssertEqualObjects(result, @"NICKEL,PENNY,PENNY,PENNY", @".42 from .50 should result in one nickel and three pennies change.");

    result = [ChangeDispenser dispenseChangeForPrice:[NSDecimalNumber decimalNumberWithString:@".25"] withCash:[NSDecimalNumber decimalNumberWithString:@".50"]];
    STAssertEqualObjects(result, @"QUARTER", @".25 from .50 should result in a quarter change.");

    result = [ChangeDispenser dispenseChangeForPrice:[NSDecimalNumber decimalNumberWithString:@".23"] withCash:[NSDecimalNumber decimalNumberWithString:@".50"]];
    STAssertEqualObjects(result, @"PENNY,PENNY,QUARTER", @".23 from .50 should result in a quarter and two pennies change.");

    result = [ChangeDispenser dispenseChangeForPrice:[NSDecimalNumber decimalNumberWithString:@"217.12"] withCash:[NSDecimalNumber decimalNumberWithString:@"604.78"]];
    STAssertEqualObjects(result, @"DIME,FIFTY,FIVE,HALF DOLLAR,HUNDRED,HUNDRED,HUNDRED,NICKEL,ONE,ONE,PENNY,TEN,TWENTY", @"217.12 from 604.78 should result in something different altogether.");
}

- (void)testThrowsErrorOnNegativeAmounts
{
    STAssertThrows([ChangeDispenser dispenseChangeForPrice:[NSDecimalNumber minimumDecimalNumber] withCash:[NSDecimalNumber zero]], 
                   @"Should throw exception if price is negative.");

    STAssertThrows([ChangeDispenser dispenseChangeForPrice:[NSDecimalNumber zero] withCash:[NSDecimalNumber minimumDecimalNumber]], 
                   @"Should throw exception if price is negative.");

    STAssertThrows([ChangeDispenser dispenseChangeForPrice:nil withCash:[NSDecimalNumber zero]], 
                   @"Should throw exception if price is negative.");

    STAssertThrows([ChangeDispenser dispenseChangeForPrice:[NSDecimalNumber zero] withCash:nil], 
                   @"Should throw exception if price is negative.");
}
@end
