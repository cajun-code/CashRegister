//
//  ChangeDespenser.m
//  CashRegister
//
//  Created by Douglas Patrick Caldwell on 9/12/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "ChangeDispenser.h"

#define IsNegative(number) [number compare:[NSDecimalNumber zero]] == NSOrderedAscending

@interface ChangeDispenser()

+(NSArray *)denominations;
+(NSArray *)makeChangeFor:(NSDecimalNumber *)value;

@end

@implementation ChangeDispenser

static NSArray* _denominations;
+(NSArray *)denominations
{
    if (_denominations == nil)
    {
        NSMutableArray *array = [NSMutableArray new];
        
        [array addObject:[Denomination fromName:@"HALF DOLLAR" andStringValue:@".5"]];
        [array addObject:[Denomination fromName:@"QUARTER" andStringValue:@".25"]];
        [array addObject:[Denomination fromName:@"DIME" andStringValue:@".1"]];
        [array addObject:[Denomination fromName:@"NICKEL" andStringValue:@".05"]];
        [array addObject:[Denomination fromName:@"PENNY" andStringValue:@".01"]];
        
        _denominations = [array copy];
    }
    
    return _denominations;
}

+ (NSString *)dispenseChangeForPrice:(NSDecimalNumber *)purchasePrice withCash:(NSDecimalNumber *)cash
{
    static NSString* const ZERO = @"ZERO";
    static NSString* const ERROR = @"ERROR";

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
    
    NSArray *changeArray = [[self class] makeChangeFor:change];
    return [changeArray componentsJoinedByString:@","];
}

+(NSArray *)makeChangeFor:(NSDecimalNumber *)value
{
    NSMutableArray *denominations = [[[self class] denominations] mutableCopy];
    NSDecimalNumber *change = [value copy];
    NSMutableArray *result = [NSMutableArray new];
    
    while (denominations.count > 0 && [change compare:[NSDecimalNumber zero]] == NSOrderedDescending)
    {
        while([((Denomination *)[denominations objectAtIndex:0]).value compare:change] == NSOrderedDescending)
            [denominations removeObjectAtIndex:0];
        
        Denomination *currentDenomination = [denominations objectAtIndex:0];
        [result addObject:currentDenomination.name];
        change = [change decimalNumberBySubtracting:currentDenomination.value];
    }
    
    return [result copy];
}

@end
