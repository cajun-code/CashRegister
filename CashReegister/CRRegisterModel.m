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
@synthesize currencyList;


- (void)setCashCollected:(NSDecimalNumber *)cashCollected
{
    // set bad data to 0.  only deal with non-negative cash
    if ((cashCollected == nil)
        || ([[NSDecimalNumber zero] compare:cashCollected] == NSOrderedDescending))
        _cashCollected = [NSDecimalNumber zero];
    else
        _cashCollected = cashCollected;
}

- (void)setPurchasePrice:(NSDecimalNumber *)purchasePrice
{
    // set bad data to 0.  only deal with non-negative purchasePrices
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
    NSString *changeString = @"";
    
    NSDecimalNumber *chg = [self computeChange];
    if (chg == nil) {
        changeString = @"ERROR";
    } else {
        NSMutableArray *breakdown = [self makeBreakdownWithValue:chg];
        
        [breakdown sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
        for (NSString *str in breakdown)
            changeString = [changeString stringByAppendingFormat:@"%@,",str];
        if ([changeString length]>0) //string off the final comma
            changeString = [changeString substringToIndex:[changeString length]-1];

        NSLog(@">>>>>>>>>>>>>> %@", changeString);
    }
    
    return changeString;
}


- (NSMutableArray *)makeBreakdownWithValue:(NSDecimalNumber *)decimalVal
{

    NSMutableArray *ma = [[NSMutableArray alloc] init];
    NSDecimalNumber *workingDecimalVal = decimalVal;
    
    // self.currencyList is array of amount/description dictionaries (e.g. @"10.0" / @"TEN" ).  The values are in decending order.
    // We loop thru as many of each amount/description as possible, subtracting along the way, and choosing lower and lower amonts.
    // We stop only when we are out of values and nothing more can be subtracted.  If we hit the last object and it's a 0, tack that on.
    
    
    for (NSDictionary *currencyItem in self.currencyList) {
        
        NSDecimalNumber *workingCurrencyVal = [NSDecimalNumber decimalNumberWithString:[currencyItem objectForKey:@"amount"]];
        
        if ([workingCurrencyVal compare:[NSDecimalNumber zero]]==NSOrderedSame) {
            if ([ma count]==0) {
                // we've come to end and there were no matches, so tack on the 0 description
                [ma addObject:[currencyItem objectForKey:@"description"]];
            }
        } else {
            while (([workingDecimalVal compare:workingCurrencyVal])==NSOrderedDescending || ([workingDecimalVal compare:workingCurrencyVal]==NSOrderedSame)) {
                
                [ma addObject:[currencyItem objectForKey:@"description"]];
                workingDecimalVal = [workingDecimalVal decimalNumberBySubtracting:workingCurrencyVal];
                
            }
        }
    }
    
    return ma;
}


@end
