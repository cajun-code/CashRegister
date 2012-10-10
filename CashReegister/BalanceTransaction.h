//
//  BalanceTransaction.h
//  CashReegister
//
//  Created by Venkateshwara Rao on 10/9/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BalanceOutput.h"

@interface BalanceTransaction : NSObject

-(BalanceOutput*) calculateBalanceWithPrice:(NSString*) pPrice andCachReceived : (NSString*) cachReceived;
@end
