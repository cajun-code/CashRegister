//
//  KSChange.m
//  CashReegister
//
//  Created by Kishore on 9/19/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "KSChange.h"

@implementation KSChange
@synthesize count, denomination, value;

+(KSChange*) changeForDenomination:(NSString*)denomination andCount:(int)count havingValue:(float)value
{
    KSChange *change = [[KSChange alloc] init];
    change.denomination = denomination;
    change.count = count;
    change.value = [[NSDecimalNumber alloc] initWithFloat:value];
    return change;    
}
@end
