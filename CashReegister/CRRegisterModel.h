//
//  CRRegisterModel.h
//  CashReegister
//
//  Created by Brad Wiederholt on 11/15/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRRegisterModel : NSObject

// presently CRRegisterModel is focused on making change, but can grow up to model more cash register features.

@property (nonatomic, strong) NSDecimalNumber *cashCollected;
@property (nonatomic, strong) NSDecimalNumber *purchasePrice;

- (NSDecimalNumber *)computeChange;
- (NSString *)computeChangeAsString;

@end
