//
//  ViewController.m
//  CashReegister
//
//  Created by Allan Davis on 8/22/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "ViewController.h"

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
    NSURL *lfileUrl = [NSURL fileURLWithPath:pInputFilePath];
    //NSString *lInputString = [NSString stringWithContentsOfURL:lfileUrl encoding:NSUTF8StringEncoding error:&lError];
    
    //inputs are hardcoded for testing purpose
    NSString *lInputString = @"15.94;16.00\n17;16\n35;35\n45;50";
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
        float lPurchasePrice = [[lPPAndCash objectAtIndex:0] floatValue];
        float lCash = [[lPPAndCash objectAtIndex:1] floatValue];
        
        if (lPurchasePrice > lCash) {
            [lCashOutput addObject:@"ERROR"];
        }
        else if (lPurchasePrice == lCash)
        {
            [lCashOutput addObject:@"ZERO"];
        }
        else
        {
            float lChangeFlaotValue = lCash - lPurchasePrice;
            NSNumber *lChangeValue = [NSNumber numberWithFloat:lChangeFlaotValue];
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            formatter.positiveFormat = @"00.##";
            int lDollarVal = [[formatter stringFromNumber:lChangeValue] integerValue];
            formatter.positiveFormat = @"##.00";
            NSString *lcentstr = [formatter stringFromNumber:lChangeValue];
            int lCentVal = [lcentstr floatValue] * 100;
            lDollarDenominations = [self CalculateDenominants:lDollarVal denominations:lDollars];
            
            lCentDenominations = [self CalculateDenominants:lCentVal denominations:lCents];
        }
    
    
    
    for (NSString *lDollarKey in lDollarDenominations)
    {
        [lCashOutput addObject:[lDenominatesDict objectForKey:lDollarKey]];
    }
    
    for (NSString *lCentKey in lCentDenominations)
    {
        int lIntKey = [lCentKey integerValue];
        //float lFloatKey = lIntKey / 100.0;
        NSNumber *lFloatkey = [NSNumber numberWithFloat:lIntKey / 100.0];
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.positiveFormat = @"##.00";
        
        NSString *lStrCentKey = [formatter stringFromNumber:lFloatkey];
        [lCashOutput addObject:[lDenominatesDict objectForKey:lStrCentKey]];
    }
    
    [self printOutput:lCashOutput];
        //clear the lCashOutput so that next time it won't print the old values again
        [lCashOutput removeAllObjects];
    
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
    //    for (int i = 0; i < lNoOfDenominations; i++) {
    //        [lDenominations addObject:@"0"];
    //    }
    
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
        //[lDenominations replaceObjectAtIndex:i - 1 withObject:[NSString stringWithFormat:@"%d", lDenom]];
        
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
    NSMutableString *lOutput = [[NSMutableString alloc] init];
    
    for (NSString *lValue in pOutput)
    {
        [lOutput appendFormat:@"%@,",lValue];
    }
    
    NSString *lFormattedOutput = [NSString stringWithFormat:@"%@\n\n", [lOutput substringToIndex:lOutput.length - 1]];
    

    self.ReturnDenominantsOutput.text = [self.ReturnDenominantsOutput.text stringByAppendingString:lFormattedOutput];
}

@end
