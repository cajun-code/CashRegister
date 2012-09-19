//
//  KSChange.m
//  CashReegister
//
//  Created by Kishore on 9/19/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "KSChange.h"

@implementation KSChange
@synthesize count, denomination, value;

+(KSChange*) changeForDenomination:(NSString*)denomination andCount:(int)count havingValue:(float)value
{
    KSChange *change = [[KSChange alloc] init];
    change.denomination = denomination;
    change.count = count;
    change.value = [[NSDecimalNumber alloc] initWithFloat:value];
    return change;    
}

-(NSDecimalNumber*) adjustBalance:(NSDecimalNumber*)balance
{
    
    //If the current denomination value is more than it can hold, do not do anything.
    if ([self.value compare:balance] == NSOrderedDescending) 
        return [balance copy];        
    
    //Static number handler to make sure we round down properly the money.
    static NSDecimalNumberHandler *roundDown = nil;    
    static dispatch_once_t onceToken;    
    dispatch_once(&onceToken, ^{
        roundDown = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                                                           scale:2
                                                                raiseOnExactness:NO
                                                                 raiseOnOverflow:NO
                                                                raiseOnUnderflow:NO
                                                             raiseOnDivideByZero:NO];
        
    });
    
    //How many of the current denominations can be subtracted?
    int cCount = [[balance decimalNumberByDividingBy:self.value withBehavior:roundDown] intValue];
    
    self.count = cCount;
    
    //Actaul deducted amount.
    double cAmount = cCount * [self.value doubleValue];
    
    //compute the remaining balance.
    NSDecimalNumber *adjBal = [balance decimalNumberBySubtracting:[[NSDecimalNumber alloc] initWithDouble:cAmount]];
    return adjBal;
}


+(KSChange*) zeroChange
{
    return [KSChange changeForDenomination:kZeroDenomination andCount:0 havingValue:0.f];
}

+(KSChange*) error
{
    return [KSChange changeForDenomination:kErrorDenomination andCount:-1 havingValue:NAN];
}


+(KSChange*) hundreds:(int)count
{
    return [KSChange changeForDenomination:kHundredsDenomination andCount:count havingValue:100];
}

+(KSChange*) fifties:(int)count
{
    return [KSChange changeForDenomination:kFiftiesDenomination andCount:count havingValue:50];
}

+(KSChange*) twenties:(int)count
{
    return [KSChange changeForDenomination:kTwentiesDenomination andCount:count havingValue:20];
}

+(KSChange*) tens:(int)count
{
    return [KSChange changeForDenomination:kTensDenomination andCount:count havingValue:10];
}

+(KSChange*) fives:(int)count
{
    return [KSChange changeForDenomination:kFivesDenomination andCount:count havingValue:5];
}

+(KSChange*) twos:(int)count
{
    return [KSChange changeForDenomination:kTwosDenomination andCount:count havingValue:2];
}

+(KSChange*) singles:(int)count
{
    return [KSChange changeForDenomination:kSinglesDenomination andCount:count havingValue:1];
}

+(KSChange*) halfDollars:(int)count
{
    return [KSChange changeForDenomination:kHalfDollarsDenomination andCount:count havingValue:0.5f];
}

+(KSChange*) quarters:(int)count
{
    return [KSChange changeForDenomination:kHalfDollarsDenomination andCount:count havingValue:0.25f];
}

+(KSChange*) dimes:(int)count
{
    return [KSChange changeForDenomination:kDimesDenomination andCount:count havingValue:0.10f];
}

+(KSChange*) nickels:(int)count
{
    return [KSChange changeForDenomination:kNickelsDenomination andCount:count havingValue:0.05f];
}

+(KSChange*) pennies:(int)count
{
    return [KSChange changeForDenomination:kPenniesDenomination andCount:count havingValue:0.01f];
}


@end
