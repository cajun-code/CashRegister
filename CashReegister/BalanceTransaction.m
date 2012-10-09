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
@property(nonatomic,strong) NSMutableArray* cashDenomination;
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
            NSLog(@"Array %@",array);
            //Sort the array based upon currency value
            [array sortUsingComparator:^NSComparisonResult(Denomination *obj1, Denomination *obj2) {
                return [obj2.value compare :obj1.value ];
            }];
            
            NSLog(@"Array %@",array);
            self.cashDenomination = array;
        }
        
        return self;
    }
    
    return nil;
}


-(BalanceOutput*) calculateBalanceWithPrice:(NSString*) pPrice andCachReceived : (NSString*) cachReceived
{
    BalanceOutput* bOUtput = [[BalanceOutput alloc] init];
    
    return bOUtput;
}

@end
