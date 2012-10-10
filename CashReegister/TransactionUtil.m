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
+(NSDecimalNumber*) convertToDecimalFromStringWithFormat:(NSString*) inputValue
{     
    NSNumber *number =  [[TransactionUtil getCurrencyFormatter] numberFromString:inputValue];
   return  [[[NSDecimalNumber alloc] initWithFloat : number.floatValue]  decimalNumberByRoundingAccordingToBehavior:[TransactionUtil roundingHandler]];
//    return [[NSDecimalNumber decimalNumberWithString:inputValue] decimalNumberByRoundingAccordingToBehavior:[TransactionUtil roundingHandler]];
}

//Converts given string to NSDecimalNumber. We make sure we pass valid number as a String.
+(NSDecimalNumber*) convertToDecimalFromString:(NSString*) inputValue
{     
    return [[NSDecimalNumber decimalNumberWithString:inputValue] decimalNumberByRoundingAccordingToBehavior:[TransactionUtil roundingHandler]];
}

@end
