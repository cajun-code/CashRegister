//
//  BalanceOutput.h
//  CashReegister
//
//  Created by Venkateshwara Rao on 10/9/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BalanceOutput : NSObject

@property(nonatomic)BOOL isError;
@property(nonatomic,strong)NSDecimalNumber* balance;
//Array of Denomination objects
@property(nonatomic,strong) NSMutableArray* output;

@end
