//
//  Denomination.m
//  CashReegister
//
//  Created by Venkateshwara Rao on 10/9/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "Denomination.h"
#import "TransactionUtil.h"

@implementation Denomination
@synthesize count, title, value;

- (id)init
{
    self = [super init];
    
    if (self)
        return self;
    
    return nil;
}

-(id) initWithTitle:(NSString*) titleVal andValue : (NSString*) val
{
    self = [super init];    
    
    if(self)
    {
        self.title = titleVal;
        self.value =   [TransactionUtil convertToDecimalFromString:val];
        return self;
    }
    
    return nil;
}

@end
