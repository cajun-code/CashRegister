//
//  KSCashRegister.m
//  CashReegister
//
//  Created by Kishore on 9/19/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "KSCashRegister.h"
#import "KSChange.h"
@implementation KSCashRegister


+(NSArray*) availableDenominations
{
    NSMutableArray *denominations = [[NSMutableArray alloc] init];
    [denominations addObject:[KSChange hundreds:0]];
    [denominations addObject:[KSChange fifties:0]];
    [denominations addObject:[KSChange twenties:0]];
    [denominations addObject:[KSChange tens:0]];
    [denominations addObject:[KSChange fives:0]];
    [denominations addObject:[KSChange twos:0]];
    [denominations addObject:[KSChange singles:0]];
    [denominations addObject:[KSChange halfDollars:0]];
    [denominations addObject:[KSChange quarters:0]];
    [denominations addObject:[KSChange dimes:0]];
    [denominations addObject:[KSChange nickels:0]];
    [denominations addObject:[KSChange pennies:0]];
    return [denominations copy];
}
@end
