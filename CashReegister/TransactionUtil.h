//
//  TransactionUtil.h
//  CashReegister
//
//  Created by Venkateshwara Rao on 10/9/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionUtil : NSObject


+(NSDecimalNumberHandler*)roundingHandler;

+(NSDecimalNumber*) convertToDecimalFromString:(NSString*) inputValue;
+(NSDecimalNumber*) convertToDecimalFromStringWithFormat:(NSString*) inputValue;
+(NSNumberFormatter*) getCurrencyFormatter;

@end
