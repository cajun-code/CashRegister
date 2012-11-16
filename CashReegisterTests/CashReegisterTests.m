//
//  CashReegisterTests.m
//  CashReegisterTests
//
//  Created by Allan Davis on 8/22/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "CashReegisterTests.h"

@implementation CashReegisterTests

@synthesize crModel;

- (void)setUp
{
    [super setUp];
    
    self.crModel = [[CRRegisterModel alloc] init];
}

- (void)tearDown
{
    self.crModel = nil;
    
    [super tearDown];
}

- (void)testCRRegisterModel
{
    NSDecimalNumber *cc;
    NSDecimalNumber *pp;
    NSDecimalNumber *chg;
    NSComparisonResult cr;
    
    // test cash collected property roundtrips
    [self.crModel setCashCollected:nil];
    cc = self.crModel.cashCollected;
    cr = [cc compare:[NSDecimalNumber decimalNumberWithString:@"0.00"]];
    STAssertTrue(cr == NSOrderedSame , @"register model should have forced bad input to 0");
    
    [self.crModel setCashCollected:[NSDecimalNumber decimalNumberWithString:@"-0.01"]];
    cc = self.crModel.cashCollected;
    cr = [cc compare:[NSDecimalNumber decimalNumberWithString:@"0.00"]];
    STAssertTrue(cr == NSOrderedSame , @"register model should have forced negative input to 0");
    
    [self.crModel setCashCollected:[NSDecimalNumber decimalNumberWithString:@"0.00"]];
    cc = self.crModel.cashCollected;
    cr = [cc compare:[NSDecimalNumber decimalNumberWithString:@"0.00"]];
    STAssertTrue(cr == NSOrderedSame , @"register model should have cash we collected");
    
    [self.crModel setCashCollected:[NSDecimalNumber decimalNumberWithString:@"0.01"]];
    cc = self.crModel.cashCollected;
    cr = [cc compare:[NSDecimalNumber decimalNumberWithString:@"0.01"]];
    STAssertTrue(cr == NSOrderedSame , @"register model should have cash we collected");
    
    // test purchase price property roundtrips
    [self.crModel setPurchasePrice:nil];
    cc = self.crModel.purchasePrice;
    cr = [cc compare:[NSDecimalNumber decimalNumberWithString:@"0.00"]];
    STAssertTrue(cr == NSOrderedSame , @"register model should have forced bad input to 0");
    
    [self.crModel setPurchasePrice:[NSDecimalNumber decimalNumberWithString:@"-0.01"]];
    cc = self.crModel.purchasePrice;
    cr = [cc compare:[NSDecimalNumber decimalNumberWithString:@"0.00"]];
    STAssertTrue(cr == NSOrderedSame , @"register model should have forced negative input to 0");
    
    [self.crModel setPurchasePrice:[NSDecimalNumber decimalNumberWithString:@"0.00"]];
    cc = self.crModel.purchasePrice;
    cr = [cc compare:[NSDecimalNumber decimalNumberWithString:@"0.00"]];
    STAssertTrue(cr == NSOrderedSame , @"register model should have cash we collected");
    
    [self.crModel setPurchasePrice:[NSDecimalNumber decimalNumberWithString:@"0.01"]];
    cc = self.crModel.purchasePrice;
    cr = [cc compare:[NSDecimalNumber decimalNumberWithString:@"0.01"]];
    STAssertTrue(cr == NSOrderedSame , @"register model should have cash we collected");

    // test price comparisons
    [self.crModel setCashCollected:[NSDecimalNumber decimalNumberWithString:@"1.00"]];
    [self.crModel setPurchasePrice:[NSDecimalNumber decimalNumberWithString:@"1.01"]];
    chg = [self.crModel computeChange];
    STAssertTrue(chg == nil, @"should have received nil if insufficient cash collected");
    
    [self.crModel setCashCollected:[NSDecimalNumber decimalNumberWithString:@"1.00"]];
    [self.crModel setPurchasePrice:[NSDecimalNumber decimalNumberWithString:@"1.00"]];
    chg = [self.crModel computeChange];
    cr = [chg compare:[NSDecimalNumber decimalNumberWithString:@"0.00"]];
    STAssertTrue(cr == NSOrderedSame, @"should have received 0 back if had exact collected cash");
    
    [self.crModel setCashCollected:[NSDecimalNumber decimalNumberWithString:@"1.01"]];
    [self.crModel setPurchasePrice:[NSDecimalNumber decimalNumberWithString:@"1.00"]];
    chg = [self.crModel computeChange];
    cr = [chg compare:[NSDecimalNumber decimalNumberWithString:@"0.01"]];
    STAssertTrue(cr == NSOrderedSame, @"should have received difference back between cash-price");
    
    // test making of change string
    [self.crModel setCashCollected:[NSDecimalNumber decimalNumberWithString:@"1.00"]];
    [self.crModel setPurchasePrice:[NSDecimalNumber decimalNumberWithString:@"1.01"]];
    NSLog(@"change string %@", [self.crModel computeChangeAsString]);
    STAssertTrue([[self.crModel computeChangeAsString] isEqualToString:@"ERROR"], @"should receive ERROR string if did not collect enough cash");
    
    
    
}

@end
