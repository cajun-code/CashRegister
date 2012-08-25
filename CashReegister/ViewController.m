//
//  ViewController.m
//  CashReegister
//
//  Created by Allan Davis on 8/22/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "ViewController.h"
#import "DecimalNumberUtils.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize ReturnDenominantsOutput;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.ReturnDenominantsOutput.text = @"";
}

- (void)viewDidUnload
{
    [self setReturnDenominantsOutput:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewWillAppear:(BOOL)animated
{
    [self CalculateChange:self.inputFilePath];
}

- (void)CalculateChange:(NSString*)pInputFilePath
{
    NSDictionary *lDenominatesDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"CENT", @".01",  @"NICKLE", @".05", @"DIME", @".10", @"QUARTER", @".25", @"ONE", @"1", @"FIVE", @"5", @"TEN", @"10", @"TWENTY", @"20", @"ONE HUNDRED", @"100", @"ERROR", @"-999", @"ZERO", @"0", nil];
    
    
    //read the inputs from the file and calculate the change
    NSError *lError = nil;
    NSString *lInputString = [NSString stringWithContentsOfFile:pInputFilePath encoding:NSUTF8StringEncoding error:&lError];
    
    //inputs are hardcoded for testing purpose
    //NSString *lInputString = @"15.94;16.00\n17;16\n35;35\n45;50";
    if (nil != lError || 0 >= lInputString.length) {
        return;
    }
    
    NSArray *lInputs = [lInputString componentsSeparatedByString:@"\n"];
    
    NSArray *lDollars = [NSArray arrayWithObjects: @"1", @"5", @"10", @"20", @"100", nil];
    NSArray *lCents = [NSArray arrayWithObjects: @"1", @"5", @"10", @"25", nil];

    NSMutableArray *lCashOutput = [[NSMutableArray alloc] init];
    NSMutableDictionary *lDollarDenominations = nil;
    NSMutableDictionary *lCentDenominations = nil;
    
    
    for (NSString *lInputStr in lInputs)
    {
        NSArray *lPPAndCash = [lInputStr componentsSeparatedByString:@";"];
        
        NSDecimalNumber *lPPCashDecimal = [[NSDecimalNumber alloc] initWithString:[lPPAndCash objectAtIndex:0]];
        
        NSDecimalNumber *lCashDecimal = [[NSDecimalNumber alloc] initWithString:[lPPAndCash objectAtIndex:1]];
        //Normal arithmatic operations can not be done on nsdecimalnumbers
        //So compare method is used for operation lPPCashDecimal > lCashDecimal
        if ([lPPCashDecimal compare:lCashDecimal] ==  NSOrderedDescending) {
            [lCashOutput addObject:@"ERROR"];
        }
        else if ([lPPCashDecimal compare:lCashDecimal] ==  NSOrderedSame)
        {
            [lCashOutput addObject:@"ZERO"];
        }
        else
        {
            NSDecimalNumber *lChangeCash = [lCashDecimal decimalNumberBySubtracting:lPPCashDecimal];
           
            lDollarDenominations = [self CalculateDenominants:[[lChangeCash dollars] integerValue] denominations:lDollars];
            
            lCentDenominations = [self CalculateDenominants:[[lChangeCash cents] integerValue] denominations:lCents];
        }
        
    
        for (NSString *lDollarKey in lDollarDenominations)
        {
            [lCashOutput addObject: [NSString stringWithFormat:@"%@ X %@",[lDenominatesDict objectForKey:lDollarKey], [lDollarDenominations objectForKey:lDollarKey]]];
        }
        
        for (NSString *lCentKey in lCentDenominations)
        {
            int lIntKey = [lCentKey integerValue];

            NSDecimalNumber *lCDecimalKey = [[NSDecimalNumber alloc] initWithMantissa:lIntKey exponent:-2 isNegative:NO];
            NSString *lStrCentKey = [NSString stringWithFormat:@".%@", [lCDecimalKey cents]];
            
            [lCashOutput addObject:[NSString stringWithFormat:@"%@ X %@",[lDenominatesDict objectForKey:lStrCentKey], [lCentDenominations objectForKey:lCentKey]]];
        }
        
        [self printOutput:lCashOutput];
        //clear the lCashOutput, lDollarDenominations, lCentDenominations so that next time it won't print the old values again
        [lCashOutput removeAllObjects];
        [lDollarDenominations removeAllObjects];
        [lCentDenominations removeAllObjects];
    
    }
}

- (NSMutableDictionary *)CalculateDenominants:(NSInteger)pChangeAmount denominations:(NSArray *)pDenominations
{
    int lNoOfDenominations = pDenominations.count;
    
    //check if amount is zero or if there is no denominations
    //then return nil
    if (0 == pChangeAmount || nil == pDenominations || 0 >=pDenominations.count)
    {
        return nil;
    }
    
    NSMutableDictionary *lDenominations = [[NSMutableDictionary alloc] init];
    
    int lAmount = pChangeAmount;
    int i = lNoOfDenominations;
    
    while (lAmount > 0) {
        int lDivider = [[pDenominations objectAtIndex:i-1] integerValue];
        int lDenom = lAmount / lDivider;
        lAmount = lAmount % lDivider;
        
        if (lDenom > 0)
        {
            [lDenominations setObject:[NSString stringWithFormat:@"%d", lDenom] forKey:[NSString stringWithFormat:@"%d", lDivider]];
        }
        
        i = i - 1;
    }
    
    for (NSString *key in lDenominations)
    {
        NSLog(@"Denomination %@: %@", key, [lDenominations objectForKey:key]);
    }
    
    return lDenominations;
}


- (void)printOutput:(NSMutableArray *)pOutput
{
    if (nil == pOutput || 0 >= pOutput.count)
    {
        return;
    }
    
    NSArray *lSortedOutput = [pOutput sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSMutableString *lOutput = [[NSMutableString alloc] init];
    
    for (NSString *lValue in lSortedOutput)
    {
        [lOutput appendFormat:@"%@,",lValue];
    }
    
    NSString *lFormattedOutput = [NSString stringWithFormat:@"%@\n\n", [lOutput substringToIndex:lOutput.length - 1]];
    

    self.ReturnDenominantsOutput.text = [self.ReturnDenominantsOutput.text stringByAppendingString:lFormattedOutput];
}

@end
