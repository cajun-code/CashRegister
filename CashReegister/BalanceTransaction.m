//
//  BalanceTransaction.m
//  CashReegister
//
//  Created by Venkateshwara Rao on 10/9/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "BalanceTransaction.h"
#import "Denomination.h"
#import "TransactionUtil.h"

@interface BalanceTransaction()
@property(nonatomic,strong) NSArray* cashDenomination;
@end

@implementation BalanceTransaction

@synthesize cashDenomination;

-(id) init
{
    if(self = [super init])
    {
        @synchronized(self)
        {
            //We need to make sure this file is available. 
            NSString *path = [[NSBundle mainBundle] pathForResource:@"Denominations" ofType:@"plist"];
            
            // Load the file content and read the data into arrays
            NSDictionary *denominations = [[NSDictionary alloc] initWithContentsOfFile:path];
            NSMutableArray *array = [NSMutableArray array];
            
            //loads the property list into Array
            [ denominations enumerateKeysAndObjectsUsingBlock:^(NSString* title, NSString* value, BOOL *stop) {
                [array addObject:[[Denomination alloc]  initWithTitle:title andValue :value ]];
                 NSLog(@"Val %@",value);
            }];
            NSLog(@"Denomination Array %@",array);
            //Sort the array based upon currency value
            [array sortUsingComparator:^NSComparisonResult(Denomination *obj1, Denomination *obj2) {
                return [obj2.value compare :obj1.value ];
            }];
            
            NSLog(@"Sorted Array %@",array);
            self.cashDenomination = [array copy];
        }
        
        return self;
    }
    
    return nil;
}

//Calculate the balance and convert into denominations
-(BalanceOutput*) calculateBalanceWithPrice:(NSString*) pPrice andCachReceived : (NSString*) cachReceived
{
    BalanceOutput* trBalance = [[BalanceOutput alloc] init];
    //Converting string into NSDecimal Number
    NSDecimalNumber* purchasePrice = [TransactionUtil convertToDecimalFromString:pPrice];
    NSDecimalNumber* cReceived = [TransactionUtil convertToDecimalFromString:cachReceived];
    
    //checking both purchasePrice and Cash Received are same or not.
    if([cReceived compare:purchasePrice] == 0)
        return trBalance;
    
    //Checking whether Cash Received is greater than purchase price.
    if([cReceived compare:purchasePrice] < 0)
    {
        trBalance.isError = YES;
        trBalance.balance = [NSDecimalNumber zero];
        return trBalance;
    }
    //Calculating the change
    NSDecimalNumber* change = [cReceived decimalNumberBySubtracting:purchasePrice withBehavior:[TransactionUtil roundingHandler]];
    trBalance.balance = change;
    
    NSMutableArray* output = [NSMutableArray array];
    NSDecimalNumber* balance = [change copy];
    NSArray* copyDenominations = [self.cashDenomination copy];

    //Converting the change into Denominations
    for(Denomination* denomination in copyDenominations)
    {
        NSLog(@"Balance is %f",[balance floatValue]);
        NSLog(@"%@ Currrency %f count %i", denomination.title,[denomination.value floatValue],denomination.count);
        if([balance compare:denomination.value ] >= 0)
        {
            
            denomination.count = [[balance decimalNumberByDividingBy: denomination.value withBehavior:[TransactionUtil roundingHandler]] intValue];
            [output addObject:denomination];
            balance = [balance decimalNumberBySubtracting:[denomination.value decimalNumberByMultiplyingBy:[[NSDecimalNumber alloc] initWithInt: denomination.count]]];
            if([balance isEqual:[NSDecimalNumber zero]])
                break;
        }
    }
    trBalance.output = [output copy];
    return trBalance;
}

@end
