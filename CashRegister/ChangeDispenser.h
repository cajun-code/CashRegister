//
//  ChangeDespenser.h
//  CashRegister
//
//  Created by Douglas Patrick Caldwell on 9/12/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangeDispenser : NSObject

+ (NSString*)dispenseChangeFor:(NSDecimalNumber *)purchasePrice withCash:(NSDecimalNumber *)cash;

@end
