//
//  CashReegisterCalculator.m
//  CashReegister
//
//  Created by Eric Levy on 9/27/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "CashReegisterCalculator.h"

@implementation CashReegisterCalculator

@synthesize mtbldictCashRoll = _mtbldictCashRoll;
@synthesize dictDenominationValues = _dictDenominationValues;


+(NSString *) cellCacheIdentifier
{
    return @"CashBackCell";
}

+(float) totalCashBackFromCashBackList: (NSArray *) arrCashback
{
    // this is pretty hard coded, but it's only suppost to take the array that it itself return to the View Controller
    
    float fTotalCashBackFromCashBackList = 0.00;
    for (int i = 0; i < [arrCashback count]; i++)
    {
        if ([[arrCashback objectAtIndex:i] count] == 3)
        {
            fTotalCashBackFromCashBackList += [[[arrCashback objectAtIndex:i] objectAtIndex:2] floatValue];
        }
    }
    
    return fTotalCashBackFromCashBackList;
}



// getters and setter
-(NSMutableDictionary *) mtbldictCashRoll
{
    if (!_mtbldictCashRoll)
    {
        _mtbldictCashRoll = [[NSMutableDictionary alloc] init];
    }
    return _mtbldictCashRoll;
}

-(NSDictionary *) dictDenominationValues
{
    if (!_dictDenominationValues)
    {
        _dictDenominationValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   [NSNumber numberWithFloat:100.00], DENOMINATION_HUNDRED,
                                   [NSNumber numberWithFloat:50.00], DENOMINATION_FIFTY,
                                   [NSNumber numberWithFloat:20.00], DENOMINATION_TWENTY,
                                   [NSNumber numberWithFloat:10.00], DENOMINATION_TEN,
                                   [NSNumber numberWithFloat:5.00], DENOMINATION_FIVE,
                                   [NSNumber numberWithFloat:2.00], DENOMINATION_TWO,
                                   [NSNumber numberWithFloat:1.00], DENOMINATION_SINGLE,
                                   [NSNumber numberWithFloat:0.50], DENOMINATION_HALFDOLLAR,
                                   [NSNumber numberWithFloat:0.250], DENOMINATION_QUARTER,
                                   [NSNumber numberWithFloat:0.10], DENOMINATION_DIME,
                                   [NSNumber numberWithFloat:0.050], DENOMINATION_NICKEL,
                                   [NSNumber numberWithFloat:0.010], DENOMINATION_PENNY,
                                                    nil];
    }
    return _dictDenominationValues;
}


// initialization routines, and routines that allow cash to the added to the cashRoll in the register

-(void) loadWithDefaultCashRoll
{
    [self clearRegister];
    [self addQuantity: [NSNumber numberWithInt:100] ofDemonination: DENOMINATION_HUNDRED];
    [self addQuantity: [NSNumber numberWithInt:100] ofDemonination: DENOMINATION_FIFTY];
    [self addQuantity: [NSNumber numberWithInt:100] ofDemonination: DENOMINATION_TWENTY];
    [self addQuantity: [NSNumber numberWithInt:100] ofDemonination: DENOMINATION_TEN];
    [self addQuantity: [NSNumber numberWithInt:100] ofDemonination: DENOMINATION_FIVE];
    [self addQuantity: [NSNumber numberWithInt:100] ofDemonination: DENOMINATION_TWO];
    [self addQuantity: [NSNumber numberWithInt:100] ofDemonination: DENOMINATION_SINGLE];
    [self addQuantity: [NSNumber numberWithInt:500] ofDemonination: DENOMINATION_HALFDOLLAR];
    [self addQuantity: [NSNumber numberWithInt:500] ofDemonination: DENOMINATION_QUARTER];
    [self addQuantity: [NSNumber numberWithInt:500] ofDemonination: DENOMINATION_DIME];
    [self addQuantity: [NSNumber numberWithInt:500] ofDemonination: DENOMINATION_NICKEL];
    [self addQuantity: [NSNumber numberWithInt:500] ofDemonination: DENOMINATION_PENNY];
}


-(id) initWithDefaultCashRoll
{
    self = [super init];
    if ( self )
    {
        self = [self initWithHundreds:[NSNumber numberWithInt:100]
                       fifties:[NSNumber numberWithInt:100]
                      twenties:[NSNumber numberWithInt:100]
                          tens:[NSNumber numberWithInt:100]
                         fives:[NSNumber numberWithInt:100]
                          twos:[NSNumber numberWithInt:100]
                       singles:[NSNumber numberWithInt:100]
                   halfDollars:[NSNumber numberWithInt:500]
                      quarters:[NSNumber numberWithInt:500]
                         dimes:[NSNumber numberWithInt:500]
                       nickels:[NSNumber numberWithInt:500]
                       pennies:[NSNumber numberWithInt:500]];
    }
    return self;
}

-(id) initWithHundreds: (NSNumber *) nHundreds fifties: (NSNumber *) nFifties twenties:(NSNumber *) nTwenties tens:(NSNumber *) nTens fives:(NSNumber *) nFives twos:(NSNumber *) nTwos singles:(NSNumber *) nSingles halfDollars:(NSNumber *) nHalfDollars quarters:(NSNumber *) nQuarters dimes:(NSNumber *) nDimes nickels:(NSNumber *) nNickels pennies:(NSNumber *) nPennies
{
    if (!self)
    {
        self = [super init];
    }
    if ( self )
    {
        [self addQuantity: nHundreds ofDemonination: DENOMINATION_HUNDRED];
        [self addQuantity: nFifties ofDemonination: DENOMINATION_FIFTY];
        [self addQuantity: nTwenties ofDemonination: DENOMINATION_TWENTY];
        [self addQuantity: nTens ofDemonination: DENOMINATION_TEN];
        [self addQuantity: nFives ofDemonination: DENOMINATION_FIVE];
        [self addQuantity: nTwos ofDemonination: DENOMINATION_TWO];
        [self addQuantity: nSingles ofDemonination: DENOMINATION_SINGLE];
        [self addQuantity: nHalfDollars ofDemonination: DENOMINATION_HALFDOLLAR];
        [self addQuantity: nQuarters ofDemonination: DENOMINATION_QUARTER];
        [self addQuantity: nDimes ofDemonination: DENOMINATION_DIME];
        [self addQuantity: nNickels ofDemonination: DENOMINATION_NICKEL];
        [self addQuantity: nPennies ofDemonination: DENOMINATION_PENNY];
    }
    return self;
}

-(id) initWithMoneyRoll: (NSSet *) setMoneyRoll
{
    if (!self)
    {
        self = [super init];
    }
    if ( self )
    {
        [self addQuantity: [setMoneyRoll valueForKey:DENOMINATION_HUNDRED] ofDemonination: DENOMINATION_HUNDRED];
        [self addQuantity: [setMoneyRoll valueForKey:DENOMINATION_FIFTY] ofDemonination: DENOMINATION_FIFTY];
        [self addQuantity: [setMoneyRoll valueForKey:DENOMINATION_TWENTY] ofDemonination: DENOMINATION_TWENTY];
        [self addQuantity: [setMoneyRoll valueForKey:DENOMINATION_TEN] ofDemonination: DENOMINATION_TEN];
        [self addQuantity: [setMoneyRoll valueForKey:DENOMINATION_FIVE] ofDemonination: DENOMINATION_FIVE];
        [self addQuantity: [setMoneyRoll valueForKey:DENOMINATION_TWO] ofDemonination: DENOMINATION_TWO];
        [self addQuantity: [setMoneyRoll valueForKey:DENOMINATION_SINGLE] ofDemonination: DENOMINATION_SINGLE];
        [self addQuantity: [setMoneyRoll valueForKey:DENOMINATION_HALFDOLLAR] ofDemonination: DENOMINATION_HALFDOLLAR];
        [self addQuantity: [setMoneyRoll valueForKey:DENOMINATION_QUARTER] ofDemonination: DENOMINATION_QUARTER];
        [self addQuantity: [setMoneyRoll valueForKey:DENOMINATION_DIME] ofDemonination: DENOMINATION_DIME];
        [self addQuantity: [setMoneyRoll valueForKey:DENOMINATION_NICKEL] ofDemonination: DENOMINATION_NICKEL];
        [self addQuantity: [setMoneyRoll valueForKey:DENOMINATION_PENNY] ofDemonination: DENOMINATION_PENNY];
    }
    return self;
}


// changing what's in the cash drawers/rolls

-(void) removeQuantity: (NSNumber *) quantity ofDemonination: (NSString *) strDenomination
{
    if ([quantity integerValue] <= 0)
    {
        NSLog (@"Improper use of 'removeQuantity.' An quantity must be specified ");
        return;
    }
    
    NSNumber *nQuantityInRoll = [self.mtbldictCashRoll objectForKey:strDenomination];
    if (!nQuantityInRoll)
    {
        NSLog (@"Improper use of 'removeQuantity.' There are no %@s in the register", strDenomination);
        return;
    }
    
    if ([quantity intValue] > [nQuantityInRoll intValue])
    {
        NSLog (@"Improper use of 'removeQuantity.' There are not enough %@s in the register", strDenomination);
        return;
    }
    
    [self.mtbldictCashRoll setValue:[NSNumber numberWithInt:[nQuantityInRoll intValue] - [quantity intValue]] forKey:strDenomination];
}


-(void) addQuantity: (NSNumber *) quantity ofDemonination: (NSString *) strDenomination
{
    // semaphore.  Only take actions for a positive quabity of denominations to add
    if ([quantity integerValue] <= 0)
    {
        if ([quantity integerValue] < 0)
        {
            NSLog (@"Improper use of 'addQuantity'");
        }
        return;
    }
    
    NSNumber *nQuantityInRoll = [self.mtbldictCashRoll objectForKey:strDenomination];
    int iQuantity = (nQuantityInRoll == nil ? [quantity intValue] : [quantity intValue] + [nQuantityInRoll integerValue]);
    [self.mtbldictCashRoll setValue:[NSNumber numberWithInt:iQuantity] forKey:strDenomination];
}


-(float) valueOfDemonination: (NSString *) strDenomination
{
    NSNumber *numValue = [self.dictDenominationValues valueForKey:strDenomination];
    return (numValue == nil ? 0.00 : [numValue floatValue]);
}


-(int) quantityOfDemonination: (NSString *) strDenomination forAmount: (float) fAmount
{
    int nQuantityOfDemonination = 0;
    
    int iQuantityInRoll = [[self.mtbldictCashRoll valueForKey:strDenomination] intValue];
    
    float fValueOfDemonination = [[NSNumber numberWithFloat:[self valueOfDemonination:strDenomination]] floatValue];
    
    NSString *strValueOfDemonination = [NSString stringWithFormat:@"%.2f", fValueOfDemonination];
    NSString *strAmount = [NSString stringWithFormat:@"%.2f", fAmount];
    // I know this is ugly, but it gets rid of the imprecision of the floats, but casting to a %.2f string and then back to float.

    while ((nQuantityOfDemonination + 1) *  [strValueOfDemonination floatValue] <= [strAmount floatValue] && nQuantityOfDemonination < iQuantityInRoll)
    {
        nQuantityOfDemonination++;
    }
    return nQuantityOfDemonination;
}


-(void) clearRegister
{
    [self.mtbldictCashRoll removeAllObjects];
}

-(NSArray *) cashBackForPurchasePrice:(float) fPurchasePrice andCashGiven:(float) fCashGiven
{
    NSMutableArray *mtblarrCashBackForPurchasePrice = [[NSMutableArray alloc] init];
    float fCashBack = fCashGiven - fPurchasePrice;
    if (fCashBack == 0.00)
    {
        [mtblarrCashBackForPurchasePrice addObject:[NSArray arrayWithObjects:@"ZERO", @"Have a nice day.", nil]];
    }
    else if (fCashBack < 0.00)
    {
        [mtblarrCashBackForPurchasePrice addObject:[NSArray arrayWithObjects:@"ERROR", [NSString stringWithFormat:@"%.2f Needed", fCashBack * -1.0], nil]];
    }
    else // OK, let's give them change from what we have
    {
        // we'll start from the heighest denimination in the draw, and work down to the lowest
        NSMutableArray *mtblarrRemoveList = [[NSMutableArray alloc] init];
        NSArray *arrDenominations = [NSArray arrayWithArray:[self.dictDenominationValues keysSortedByValueUsingComparator:^(id Obj1, id Obj2)
                                                             {return [Obj2 compare:Obj1];}
                                                             ]];
        for (int i = 0; i < [arrDenominations count]; i++)
        {
            NSString *strDenomination = [arrDenominations objectAtIndex:i];
            int quantity = [self quantityOfDemonination:strDenomination forAmount:fCashBack];
            if ( quantity  > 0 )
            {
                [mtblarrCashBackForPurchasePrice addObject:[NSArray arrayWithObjects:strDenomination,
                                                                                    [NSNumber numberWithInt:quantity],
                                                                                    [NSNumber numberWithFloat:quantity * [self valueOfDemonination:strDenomination]], nil]];
                [mtblarrRemoveList addObject:[NSArray arrayWithObjects:strDenomination, [NSNumber numberWithInt:quantity], nil]];
                
                
                fCashBack -= (quantity * [self valueOfDemonination:strDenomination]);
                
            }
        }
        if ([[NSString stringWithFormat:@"%.2f", fCashBack] floatValue] > 0.00)
        {
            [mtblarrCashBackForPurchasePrice removeAllObjects];
            [mtblarrCashBackForPurchasePrice addObject:[NSArray arrayWithObjects:@"ERROR", @"Not enough cash in the register", nil]];

        }
        else  //it's safe to take out the money
        {
            for (int i = 0; i < [mtblarrRemoveList count]; i++)
            {
                [self removeQuantity:[[mtblarrRemoveList objectAtIndex:i] objectAtIndex:1] ofDemonination:[[mtblarrRemoveList objectAtIndex:i] objectAtIndex:0]];
            }
        }
    }
    return [mtblarrCashBackForPurchasePrice copy];
}

-(float) totalCashInRoll
{
    float fTotalCash = 0.00;
    NSArray *arrDenominationsInRegister = [NSArray arrayWithArray:[self.mtbldictCashRoll allKeys]];
    for (int i = 0; i < [arrDenominationsInRegister count]; i++)
    {
        fTotalCash += [[self.mtbldictCashRoll valueForKey:[arrDenominationsInRegister objectAtIndex:i]] intValue] * [self valueOfDemonination:[arrDenominationsInRegister objectAtIndex:i]];
    }
    return fTotalCash;
}

@end
