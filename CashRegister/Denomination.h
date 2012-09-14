//
//  Denomination.h
//  CashRegister
//
//  Created by Douglas Patrick Caldwell on 9/13/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Denomination : NSObject

@property (nonatomic) NSDecimalNumber *value;
@property (nonatomic) NSString *name;

+(Denomination*)fromName:(NSString *)name andValue:(NSDecimalNumber *)value;
+(Denomination*)fromName:(NSString *)name andStringValue:(NSString *)value;
                                        
@end
