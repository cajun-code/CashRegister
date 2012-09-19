//
//  CashReegisterTests.m
//  CashReegisterTests
//
//  Created by Allan Davis on 8/22/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "CashReegisterTests.h"
#import "KSCashRegister.h"
#import "KSChange.h"
#import "KSTransaction.h"

@implementation CashReegisterTests

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

- (void) testZero
{
    //35 35
    NSArray *expResult = [NSArray arrayWithObjects:[KSChange zeroChange],nil];
    KSTransaction *transaction = [KSCashRegister transactionWithCashHanded:35 andPurchasePrice:35];
    STAssertTrue([expResult isEqualToArray:transaction.output],@"Zero transactions dont work.");    
    
}

- (void) testError
{
    //45 50
    NSArray *expResult = [NSArray arrayWithObjects:[KSChange error],nil];           
    KSTransaction *transaction = [KSCashRegister transactionWithCashHanded:45 andPurchasePrice:50];
    STAssertTrue([expResult isEqualToArray:transaction.output],@"Error transactions dont work.");        
}

-(void) testMutliple
{
    NSArray *expResult = [NSArray arrayWithObjects:[KSChange halfDollars:1],[KSChange nickels:1],[KSChange pennies:3],[KSChange twos:2],nil];    
    KSTransaction *transaction = [KSCashRegister transactionWithCashHanded:10.56 andPurchasePrice:5.98];
    STAssertTrue([expResult isEqualToArray:transaction.output],@"Complex transactions dont work.");    
}

- (void) testTransaction
{
    //15.94 16.00
    NSArray *expResult = [NSArray arrayWithObjects:[KSChange nickels:1],[KSChange pennies:1],nil];
    KSTransaction *transaction = [KSCashRegister transactionWithCashHanded:16.00 andPurchasePrice:15.94];
    STAssertTrue([expResult isEqualToArray:transaction.output],@"Regular transactions dont work.");    
    
}

- (void) testTransaction2
{
    //17 16
    NSArray *expResult = [NSArray arrayWithObjects:[KSChange singles:1],nil];    
    KSTransaction *transaction = [KSCashRegister transactionWithCashHanded:17 andPurchasePrice:16];
    STAssertTrue([expResult isEqualToArray:transaction.output],@"Regular transactions dont work.");    
}

- (void) testRounding
{
    //53 12.56    
    NSArray *expResult = [NSArray arrayWithObjects:[KSChange dimes:1],[KSChange nickels:1],[KSChange pennies:4],[KSChange quarters:1],[KSChange twenties:2],nil];    
    KSTransaction *transaction = [KSCashRegister transactionWithCashHanded:53 andPurchasePrice:12.56];
    STAssertTrue([expResult isEqualToArray:transaction.output],@"Rounding transactions dont work.");    
}

@end
