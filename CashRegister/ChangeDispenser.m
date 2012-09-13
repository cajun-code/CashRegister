//
//  ChangeDespenser.m
//  CashRegister
//
//  Created by Douglas Patrick Caldwell on 9/12/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "ChangeDispenser.h"

@implementation ChangeDispenser

+ (NSString *)dispenseChangeForPrice:(NSDecimalNumber *)purchasePrice withCash:(NSDecimalNumber *)cash
{
    static NSString* const ZERO = @"ZERO";
    static NSString* const ERROR = @"ERROR";
    
    NSComparisonResult result = [purchasePrice compare:cash];
    
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
    
    return nil;
}

@end
