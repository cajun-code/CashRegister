//
//  KSTransaction.m
//  CashReegister
//
//  Created by Kishore on 9/19/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "KSTransaction.h"

@interface KSTransaction()
@property(nonatomic, strong) NSDecimalNumber *tBalance;
@property(nonatomic, strong) NSMutableArray *change;

@end

@implementation KSTransaction
@synthesize purchasePrice, cashHanded, tBalance, change;


-(NSDecimalNumber*)balance
{
    return [self.tBalance copy];
}

-(NSArray*) output
{
    return [self.change copy];
}

-(BOOL) ringTransaction
{
    return NO;
    
}
@end
