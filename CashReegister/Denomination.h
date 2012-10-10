//
//  Denomination.h
//  CashReegister
//
//  Created by Venkateshwara Rao on 10/9/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Denomination : NSObject

@property(nonatomic) int count;
@property(nonatomic, strong) NSString *title;
@property(nonatomic,strong) NSDecimalNumber* value;

-(id) initWithTitle:(NSString*) titleVal andValue : (NSString*) val;

-(id) initWithDenomination:(int) countVal andValue : (NSString*) val;

@end
