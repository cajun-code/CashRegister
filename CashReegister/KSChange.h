//
//  KSChange.h
//  CashReegister
//
//  Created by Kishore on 9/19/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSChange : NSObject

//Number for this denomination.
@property(nonatomic) int count;

//String representation of this denomination.
@property(nonatomic, strong) NSString *denomination;

//Actual Value of this denimination.
@property(nonatomic, strong) NSDecimalNumber *value;

//Convineince method to create different denominations.
+(KSChange*) changeForDenomination:(NSString*)denomination andCount:(int)count havingValue:(float)value;
@end
