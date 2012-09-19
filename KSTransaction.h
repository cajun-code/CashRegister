//
//  KSTransaction.h
//  CashReegister
//
//  Created by Kishore on 9/19/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSTransaction : NSObject
//Purchase price for the customer.
@property(nonatomic, strong) NSDecimalNumber *purchasePrice;

//Cash handed by the customer.
@property(nonatomic, strong) NSDecimalNumber *cashHanded;

//Balace/change should be returned to the customer.
@property(nonatomic, strong) NSDecimalNumber *balance;


//Run the Transaction with the given input.
-(BOOL) ringTransaction;
@end
