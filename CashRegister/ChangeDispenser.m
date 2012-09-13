//
//  ChangeDespenser.m
//  CashRegister
//
//  Created by Douglas Patrick Caldwell on 9/12/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "ChangeDispenser.h"

#define IsNegative(number) [number compare:[NSDecimalNumber zero]] == NSOrderedAscending

@implementation ChangeDispenser

+ (NSString *)dispenseChangeForPrice:(NSDecimalNumber *)purchasePrice withCash:(NSDecimalNumber *)cash
{
    static NSString* const ZERO = @"ZERO";
    static NSString* const ERROR = @"ERROR";

    // we could put this somewhere else later if we need to optimize this
    NSDecimalNumber* penny = [NSDecimalNumber decimalNumberWithString:@".01"];
    NSDecimalNumberHandler *rounder = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown 
                                                                                                    scale:2 
                                                                                         raiseOnExactness:NO 
                                                                                          raiseOnOverflow:NO 
                                                                                         raiseOnUnderflow:NO 
                                                                                      raiseOnDivideByZero:NO];
    
    if (purchasePrice == nil || IsNegative(purchasePrice))
        [NSException raise:@"Invalid Purchase Price" format:@"Purchase price of %d is missing or negative.", purchasePrice];

    if (cash == nil || IsNegative(cash))
        [NSException raise:@"Invalid Cash Provided" format:@"Cash provided of %d is missing or negative.", cash];

    // we could check for inexact currency amounts (i.e., $10.253), but as it's a cash register and a customer giving us currency
    // any partial values will likely just be pieces of breath mint or a half stick of gum, which I'll just consider a tip.
    NSDecimalNumber *change = [[cash decimalNumberBySubtracting:purchasePrice] decimalNumberByRoundingAccordingToBehavior:rounder];
    NSComparisonResult result = [[NSDecimalNumber zero] compare:change];
    
    switch (result) {
        case NSOrderedSame:
            return ZERO;
            break;
            
        case NSOrderedDescending:
            return ERROR;
            break;
            
        default:
            break;
    }
    
    NSMutableString *changeString = [NSMutableString new];
    while ([change compare:[NSDecimalNumber zero]] == NSOrderedDescending)
    {
        // this will eventually pull from a set of monetary denominations probably, and will probably try to deliver change based
        // on some heuristic of efficiency and presence of each denomination in the register.  currently the specs don't mention
        // this requirement so we'll just dish out pennies.  we hate pennies anyhow.
        [changeString appendString:@"PENNY,"];
        change = [change decimalNumberBySubtracting:penny];
    } 
    
    return [changeString substringToIndex:changeString.length - 1];
}

@end
