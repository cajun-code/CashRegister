//
//  KSTransaction.m
//  CashReegister
//
//  Created by Kishore on 9/19/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "KSTransaction.h"
#import "KSChange.h"
#import "KSCashRegister.h"
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
    //Compute Balance.
    self.tBalance = [self.cashHanded decimalNumberBySubtracting:self.purchasePrice withBehavior:[NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                                                                                                                                       scale:2
                                                                                                                                            raiseOnExactness:NO
                                                                                                                                             raiseOnOverflow:NO
                                                                                                                                            raiseOnUnderflow:NO
                                                                                                                                         raiseOnDivideByZero:NO]];
    

    if(self.balance.doubleValue < 0)
        self.tBalance = TRANSACTION_ERROR;
    
    
    NSMutableArray *output = [NSMutableArray array];
    
    
    
    if([self.tBalance isEqualToNumber:TRANSACTION_ERROR])
        [output addObject:[KSChange error]];
    else if([self.tBalance isEqualToValue:0])
        [output addObject:[KSChange zeroChange]];
    else 
    {
        __block NSDecimalNumber *currentBalance = [self.tBalance copy];
        
        NSArray *array = [KSCashRegister availableDenominations];
        
        NSArray *denominations = [array sortedArrayUsingComparator:^NSComparisonResult(KSChange *obj1, KSChange *obj2) {
            return [obj2.value compare:obj1.value];
        }];
        
        for (KSChange *obj in denominations) 
        {
            NSDecimalNumber *cBal = [obj adjustBalance:currentBalance];
            
            if(![cBal isEqualToNumber:currentBalance])
                [output addObject:obj];
            
            currentBalance = cBal;            
            
            if (currentBalance.doubleValue <= 0)
                break;
        }
    }
    
    self.change = output;    
    return NO;
    
}
@end
