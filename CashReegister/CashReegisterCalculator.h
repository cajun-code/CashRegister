//
//  CashReegisterCalculator.h
//  CashReegister
//
//  Created by Eric Levy on 9/27/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DENOMINATION_HUNDRED @"ONE HUNDRED"
#define DENOMINATION_FIFTY @"FIFTY"
#define DENOMINATION_TWENTY @"TWENTY"
#define DENOMINATION_TEN @"TEN"
#define DENOMINATION_FIVE @"FIVE"
#define DENOMINATION_TWO @"TWO"
#define DENOMINATION_SINGLE @"SINGLE"
#define DENOMINATION_HALFDOLLAR @"HALF DOLLAR"
#define DENOMINATION_QUARTER @"QUARTER"
#define DENOMINATION_DIME @"DIME"
#define DENOMINATION_NICKEL @"NICKEL"
#define DENOMINATION_PENNY @"PENNY"

@interface CashReegisterCalculator : NSObject

@property (retain, nonatomic) NSMutableDictionary *mtbldictCashRoll;
@property (retain, nonatomic) NSDictionary *dictDenominationValues;

+(NSString *) cellCacheIdentifier;
+(float) totalCashBackFromCashBackList: (NSArray *) arrCashback;


-(id) initWithHundreds: (NSNumber *) nHundreds fifties: (NSNumber *) nFifties twenties:(NSNumber *) nTwenties tens:(NSNumber *) nTens fives:(NSNumber *) nFives twos:(NSNumber *) nTwos singles:(NSNumber *) nSingles halfDollars:(NSNumber *) nHalfDollars quarters:(NSNumber *) nQuarters dimes:(NSNumber *) nDimes nickels:(NSNumber *) nNickels pennies:(NSNumber *) nPennies;
-(id) initWithMoneyRoll: (NSSet *) setMoneyRoll;
-(id) initWithDefaultCashRoll;

-(void) addQuantity: (NSNumber *) quantity ofDemonination: (NSString *) strDenomination;
-(void) loadWithDefaultCashRoll;
-(void) clearRegister;

-(float) totalCashInRoll;

-(NSArray *) cashBackForPurchasePrice:(float) fPurchasePrice andCashGiven:(float) fCashGiven;


@end
