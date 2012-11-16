//
//  CRRegisterModel.m
//  CashReegister
//
//  Created by Brad Wiederholt on 11/15/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "CRRegisterModel.h"

@implementation CRRegisterModel

@synthesize cashCollected = _cashCollected;
@synthesize purchasePrice = _purchasePrice;


- (void)setCashCollected:(NSDecimalNumber *)cashCollected
{
    // only deal with non-negative cash
    if ((cashCollected == nil)
        || ([[NSDecimalNumber zero] compare:cashCollected] == NSOrderedDescending))
        _cashCollected = [NSDecimalNumber zero];
    else
        _cashCollected = cashCollected;
}

- (void)setPurchasePrice:(NSDecimalNumber *)purchasePrice
{
    // only deal with non-negative purchasePrices
    if ((purchasePrice == nil)
        || ([[NSDecimalNumber zero] compare:purchasePrice] == NSOrderedDescending))
        _purchasePrice = [NSDecimalNumber zero];
    else
        _purchasePrice = purchasePrice;
}


- (NSDecimalNumber *)computeChange
{
    // we can't compute negative change so error
    if ([self.purchasePrice compare:self.cashCollected] == NSOrderedDescending)
        return nil;
    else
        return [self.cashCollected decimalNumberBySubtracting:self.purchasePrice];
}


- (NSString *)computeChangeAsString
{
    NSString *changeString;
    
    NSDecimalNumber *chg = [self computeChange];
    if (chg == nil) {
        changeString = @"ERROR";
    } else {
        NSMutableArray *breakdown = [self makeBreakdownWithValue:chg];
        [breakdown sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    
    return changeString;
}


- (NSMutableArray *)makeBreakdownWithValue:(NSDecimalNumber *)chg
{
    return nil;
}


@end
