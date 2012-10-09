//
//  TransactionUtil.m
//  CashReegister
//
//  Created by Venkateshwara Rao on 10/9/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "TransactionUtil.h"

@implementation TransactionUtil


//Returns the NSDecimalNumberHandler which is useful for currency calculations
+(NSDecimalNumberHandler*)roundingHandler
{
    
    static NSDecimalNumberHandler *numberHandler = nil;    
    static dispatch_once_t onceToken;    
    dispatch_once(&onceToken, ^{
        numberHandler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                                                           scale:2
                                                                raiseOnExactness:NO
                                                                 raiseOnOverflow:NO
                                                                raiseOnUnderflow:NO
                                                             raiseOnDivideByZero:NO];
        
    });
    return numberHandler;    
}
//Returns the currency formatter. Usefull for formatting input in the textfields.
+(NSNumberFormatter*) getCurrencyFormatter
{
    
    static NSNumberFormatter *format = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        format = [[NSNumberFormatter alloc] init]; 
        [format setNumberStyle:NSNumberFormatterCurrencyStyle]; 
    });
    return format;
}
//Converts given string to NSDecimalNumber. We make sure we pass valid number as a String.
+(NSDecimalNumber*) convertToDecimalFromString:(NSString*) inputValue
{
    return [[NSDecimalNumber decimalNumberWithString:inputValue] decimalNumberByRoundingAccordingToBehavior:[TransactionUtil roundingHandler]];
}

@end
