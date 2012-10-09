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

-(void) testTransaction
{
    //343.67
    BalanceOutput* balance = [self.cashTransaction calculateBalanceWithPrice:@"656.33" andCachReceived:@"1000"];
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
    
    STAssertTrue(([outPutBalance.balance compare: change1] == NSOrderedSame),@"Transaction failed.");
}
- (void)tearDown
{
    [self setCashTransaction:nil];
    
    [super tearDown];
}



@end
