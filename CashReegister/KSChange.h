//
//  KSChange.h
//  CashReegister
//
//  Created by Kishore on 9/19/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kErrorDenomination          @"ERROR"

#define kZeroDenomination           @"ZERO"

#define kHundredsDenomination       @"ONE HUNDREDS"
#define kFiftiesDenomination        @"FIFTY"
#define kTwentiesDenomination       @"TWENTY"
#define kTensDenomination           @"TEN"
#define kFivesDenomination          @"FIVE"
#define kTwosDenomination           @"TWO"
#define kSinglesDenomination        @"ONE"
#define kHalfDollarsDenomination    @"HALF DOLLAR"
#define kQuartersDenomination       @"QUARTER"
#define kDimesDenomination          @"DIME"
#define kNickelsDenomination        @"NICKEL"
#define kPenniesDenomination        @"PENNY"


@interface KSChange : NSObject

//Number for this denomination.
@property(nonatomic) int count;

//String representation of this denomination.
@property(nonatomic, strong) NSString *denomination;

//Actual Value of this denimination.
@property(nonatomic, strong) NSDecimalNumber *value;

//Convineince method to create different denominations.
+(KSChange*) changeForDenomination:(NSString*)denomination andCount:(int)count havingValue:(float)value;

//Checks to see if the current denomination can hold any amount with in the balance. If it can it will subtract the amount it can hold and returns the remaining balance.
-(NSDecimalNumber*) adjustBalance:(NSDecimalNumber*)balance;

//Handy methods for creating denominations.
+(KSChange*) zeroChange;
+(KSChange*) error;
+(KSChange*) hundreds:(int)count;
+(KSChange*) fifties:(int)count;
+(KSChange*) twenties:(int)count;
+(KSChange*) tens:(int)count;
+(KSChange*) fives:(int)count;
+(KSChange*) twos:(int)count;
+(KSChange*) singles:(int)count;
+(KSChange*) halfDollars:(int)count;
+(KSChange*) quarters:(int)count;
+(KSChange*) dimes:(int)count;
+(KSChange*) nickels:(int)count;
+(KSChange*) pennies:(int)count;

@end
