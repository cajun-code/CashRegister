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
    if(self.change.count == 0)
        @throw [NSException exceptionWithName:@"MSInvalidStateException" reason:@"The transaction must run before printing user freidnly output" userInfo:nil];
    
    [self.change sortUsingComparator:^NSComparisonResult(KSChange *obj1, KSChange *obj2) {
        return [obj1.denomination compare:obj2.denomination];
    }];
    
    return [self.change copy];
}
-(BOOL) ringTransaction
{
 
    NSDecimalNumber *mch = [self.cashHanded decimalNumberByRoundingAccordingToBehavior:[KSChange roundingHandler]];
    NSDecimalNumber *mpp = [self.purchasePrice decimalNumberByRoundingAccordingToBehavior:[KSChange roundingHandler]];
    
    self.cashHanded = mch;
    self.purchasePrice = mpp;
    
    //Compute Balance.
    self.tBalance = [self.cashHanded decimalNumberBySubtracting:self.purchasePrice withBehavior:[KSChange roundingHandler]];
    

    if(self.balance.doubleValue < 0)
        self.tBalance = TRANSACTION_ERROR;
    
    
    NSMutableArray *output = [NSMutableArray array];
    
    
    
    if([self.tBalance isEqualToNumber:TRANSACTION_ERROR])
        [output addObject:[KSChange error]];
    else if([self.tBalance isEqualToValue:[[NSDecimalNumber alloc] initWithFloat:0.f]])
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
    return [self.tBalance isEqualToNumber:TRANSACTION_ERROR];
    
}

-(BOOL) isError
{
    return [self.tBalance isEqualToNumber:TRANSACTION_ERROR];
}

@end
