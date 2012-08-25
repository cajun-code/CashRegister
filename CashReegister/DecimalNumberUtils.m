//
//  DecimalNumberUtils.m
//  CashReegister
//
//  Created by Sital Mishra on 8/25/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "DecimalNumberUtils.h"

//Category for NSDecimalNumber to have dollar and cent values
@implementation NSDecimalNumber (DollarCents)

- (NSString *)dollars {
    double value = [self doubleValue];
    unsigned int dollars = (unsigned)value;
    
    return [NSString stringWithFormat:@"%u", dollars];
}

- (NSString *)cents {
    double value = [self doubleValue];
    unsigned int dollars = (unsigned)value;
    unsigned int cents = (value * 100) - (dollars * 100);
    
    return [NSString stringWithFormat:@"%02u", cents];
}

@end
