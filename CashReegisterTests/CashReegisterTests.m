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
    
    NSBundle *applicationBundle = [NSBundle mainBundle];
    NSString *path = [applicationBundle pathForResource:@"CurrencyMapping" ofType:@"plist"];
    NSArray *arr = [[NSArray alloc] initWithContentsOfFile:path];
    
    [self.crModel setCurrencyList:arr];

}

- (void)tearDown
{
    self.crModel = nil;
    
    [super tearDown];
}

- (void)testCRRegisterModel
{
    NSDecimalNumber *dn;
    NSDecimalNumber *chg;
    NSComparisonResult cr;
    
    // test cash collected property roundtrips
    [self.crModel setCashCollected:nil];
    dn = self.crModel.cashCollected;
    cr = [dn compare:[NSDecimalNumber decimalNumberWithString:@"0.00"]];
    STAssertTrue(cr == NSOrderedSame , @"register model should have forced bad input to 0");
    
    [self.crModel setCashCollected:[NSDecimalNumber decimalNumberWithString:@"-0.01"]];
    dn = self.crModel.cashCollected;
    cr = [dn compare:[NSDecimalNumber decimalNumberWithString:@"0.00"]];
    STAssertTrue(cr == NSOrderedSame , @"register model should have forced negative input to 0");
    
    [self.crModel setCashCollected:[NSDecimalNumber decimalNumberWithString:@"0.00"]];
    dn = self.crModel.cashCollected;
    cr = [dn compare:[NSDecimalNumber decimalNumberWithString:@"0.00"]];
    STAssertTrue(cr == NSOrderedSame , @"register model should have cash we collected");
    
    [self.crModel setCashCollected:[NSDecimalNumber decimalNumberWithString:@"0.01"]];
    dn = self.crModel.cashCollected;
    cr = [dn compare:[NSDecimalNumber decimalNumberWithString:@"0.01"]];
    STAssertTrue(cr == NSOrderedSame , @"register model should have cash we collected");
    
    // test purchase price property roundtrips
    [self.crModel setPurchasePrice:nil];
    dn = self.crModel.purchasePrice;
    cr = [dn compare:[NSDecimalNumber decimalNumberWithString:@"0.00"]];
    STAssertTrue(cr == NSOrderedSame , @"register model should have forced bad input to 0");
    
    [self.crModel setPurchasePrice:[NSDecimalNumber decimalNumberWithString:@"-0.01"]];
    dn = self.crModel.purchasePrice;
    cr = [dn compare:[NSDecimalNumber decimalNumberWithString:@"0.00"]];
    STAssertTrue(cr == NSOrderedSame , @"register model should have forced negative input to 0");
    
    [self.crModel setPurchasePrice:[NSDecimalNumber decimalNumberWithString:@"0.00"]];
    dn = self.crModel.purchasePrice;
    cr = [dn compare:[NSDecimalNumber decimalNumberWithString:@"0.00"]];
    STAssertTrue(cr == NSOrderedSame , @"register model should have cash we collected");
    
    [self.crModel setPurchasePrice:[NSDecimalNumber decimalNumberWithString:@"0.01"]];
    dn = self.crModel.purchasePrice;
    cr = [dn compare:[NSDecimalNumber decimalNumberWithString:@"0.01"]];
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
    
    [self.crModel setCashCollected:[NSDecimalNumber decimalNumberWithString:@"1.01"]];
    [self.crModel setPurchasePrice:[NSDecimalNumber decimalNumberWithString:@"1.00"]];
    STAssertTrue([[self.crModel computeChangeAsString] isEqualToString:@"PENNY"], nil);

    [self.crModel setCashCollected:[NSDecimalNumber decimalNumberWithString:@"2.00"]];
    [self.crModel setPurchasePrice:[NSDecimalNumber decimalNumberWithString:@"1.00"]];
    STAssertTrue([[self.crModel computeChangeAsString] isEqualToString:@"ONE"], nil);

    [self.crModel setCashCollected:[NSDecimalNumber decimalNumberWithString:@"3.54"]];
    [self.crModel setPurchasePrice:[NSDecimalNumber decimalNumberWithString:@"1.00"]];
    STAssertTrue([[self.crModel computeChangeAsString] isEqualToString:@"HALF DOLLAR,PENNY,PENNY,PENNY,PENNY,TWO"], nil);
    
    [self.crModel setCashCollected:[NSDecimalNumber decimalNumberWithString:@"1.00"]];
    [self.crModel setPurchasePrice:[NSDecimalNumber decimalNumberWithString:@"1.00"]];
    STAssertTrue([[self.crModel computeChangeAsString] isEqualToString:@"ZERO"], nil);

    [self.crModel setCashCollected:[NSDecimalNumber decimalNumberWithString:@"288.92"]];
    [self.crModel setPurchasePrice:[NSDecimalNumber decimalNumberWithString:@"0.01"]];
    STAssertTrue([[self.crModel computeChangeAsString] isEqualToString:@"DIME,FIFTY,FIVE,HALF DOLLAR,NICKLE,ONE,ONE HUNDRED,ONE HUNDRED,PENNY,QUARTER,TEN,TWENTY,TWO"], nil);
    
    
}

@end
