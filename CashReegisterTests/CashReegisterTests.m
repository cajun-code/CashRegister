//
//  CashReegisterTests.m
//  CashReegisterTests
//
//  Created by Allan Davis on 8/22/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "CashReegisterTests.h"
#import "BalanceTransaction.h"
#import "BalanceOutput.h"
#import "TransactionUtil.h"
#import "Denomination.h"

@interface CashReegisterTests()

@property(nonatomic,strong) BalanceTransaction* cashTransaction;
@end

@implementation CashReegisterTests
@synthesize cashTransaction;

- (void)setUp
{
    [super setUp];
    
    self.cashTransaction = [[BalanceTransaction alloc] init];
}

-(void) testCaseError
{
    BalanceOutput* balance = [self.cashTransaction calculateBalanceWithPrice:@"$150.20" andCachReceived:@"$105.23"];
    STAssertTrue(balance.isError,@"Error Test case failed.");
}

-(void) testCaseZero
{
    BalanceOutput* balance = [self.cashTransaction calculateBalanceWithPrice:@"45.34" andCachReceived:@"45.34"];
    
    STAssertTrue(([balance.output count]  == NSOrderedSame),@"Zero test case failed.");
}

-(void) testCaseZero1
{
    BalanceOutput* balance = [self.cashTransaction calculateBalanceWithPrice:@"45" andCachReceived:@"45"];
    
    STAssertTrue(([balance.output count]  == NSOrderedSame),@"Zero test case failed.");
}

-(void) testTransaction
{
    //343.67
    BalanceOutput* balance = [self.cashTransaction calculateBalanceWithPrice:@"$656.33" andCachReceived:@"$1000"];
    NSDecimalNumber *change1 = [NSDecimalNumber zero];
    for(Denomination* obj in balance.output)
    {
        NSDecimalNumber *temp = [obj.value decimalNumberByMultiplyingBy:[[NSDecimalNumber alloc] initWithInt:obj.count ]  withBehavior:[TransactionUtil roundingHandler] ];
        NSLog(@"%f temp value",[temp floatValue]);
        change1 = [change1 decimalNumberByAdding:temp  withBehavior:[TransactionUtil roundingHandler] ];
        
        NSLog(@"%f value",[change1 floatValue]);
    }
    
    BalanceOutput* outPutBalance = [[BalanceOutput alloc] init];
    
    outPutBalance.balance = [NSDecimalNumber decimalNumberWithString:@"343.67"];
    
    outPutBalance.output = [[NSMutableArray alloc ] initWithObjects:[[Denomination alloc] initWithDenomination:3 andValue:@"100"],[[Denomination alloc] initWithDenomination:2 andValue:@"20"],[[Denomination alloc] initWithDenomination:1 andValue:@"2"],[[Denomination alloc] initWithDenomination:1 andValue:@"1"],[[Denomination alloc] initWithDenomination:1 andValue:@"0.50"],[[Denomination alloc] initWithDenomination:1 andValue:@"0.1"],[[Denomination alloc] initWithDenomination:1 andValue:@"0.05"], [[Denomination alloc] initWithDenomination:2 andValue:@"0.01"], nil];
    //Checking the balance calculation
    STAssertTrue(([outPutBalance.balance compare: change1] == NSOrderedSame),@"Transaction failed.");
    //checking the denomination match
    STAssertTrue([balance.output isEqualToArray:outPutBalance.output],@"Transaction failed.");
}

-(void) testCaseTransaction1
{
    //0.06
    BalanceOutput* balance = [self.cashTransaction calculateBalanceWithPrice:@"$15.94" andCachReceived:@"$16"];
    NSDecimalNumber *change1 = [NSDecimalNumber zero];
    for(Denomination* obj in balance.output)
    {
        NSDecimalNumber *temp = [obj.value decimalNumberByMultiplyingBy:[[NSDecimalNumber alloc] initWithInt:obj.count ]  withBehavior:[TransactionUtil roundingHandler] ];
        NSLog(@"%f temp value",[temp floatValue]);
        change1 = [change1 decimalNumberByAdding:temp  withBehavior:[TransactionUtil roundingHandler] ];
        
        NSLog(@"%f value",[change1 floatValue]);
    }
    
    BalanceOutput* outPutBalance = [[BalanceOutput alloc] init];
    
    outPutBalance.balance = [NSDecimalNumber decimalNumberWithString:@"0.06"];
    
    outPutBalance.output = [[NSMutableArray alloc ] initWithObjects:[[Denomination alloc] initWithDenomination:1 andValue:@"0.05"],[[Denomination alloc] initWithDenomination:1 andValue:@"0.01"],  nil];
    
    
    STAssertTrue(([outPutBalance.balance compare: change1] == NSOrderedSame),@"Transaction failed.");
    STAssertTrue([balance.output isEqualToArray:outPutBalance.output],@"Transaction failed.");
}
- (void)tearDown
{
    [self setCashTransaction:nil];
    
    [super tearDown];
}



@end
