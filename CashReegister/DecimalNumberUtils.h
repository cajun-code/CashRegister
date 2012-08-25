//
//  DecimalNumberUtils.h
//  CashReegister
//
//  Created by Sital Mishra on 8/25/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber (DollarCents)

- (NSString *)dollars;
- (NSString *)cents;

@end
