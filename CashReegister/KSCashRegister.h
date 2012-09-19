//
//  KSCashRegister.h
//  CashReegister
//
//  Created by Kishore on 9/19/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSCashRegister : NSObject

//Return what are the denominations available with in this cash register.
+(NSArray*) availableDenominations;

@end
