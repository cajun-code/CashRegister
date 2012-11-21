//
//  ViewController.m
//  CashReegister
//
//  Created by Allan Davis on 8/22/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (NSString *)performTransaction:(CGFloat)purchasePrice withAmount:(CGFloat)amount;

- (NSString *)convertChange:(CGFloat)change;

@end

@implementation ViewController

@synthesize summaryLabel, answerLabel;
@synthesize purchasePriceText, amountTenderedText;

#pragma mark - Event Handler

- (IBAction)buttonHandler:(id)sender {
    
    // ---------------------------------------------------------------------------------
    
    [[self summaryLabel] setText:@""];
    
    [[self answerLabel] setText:@""];
    
    // ---------------------------------------------------------------------------------
    
    [[self purchasePriceText] resignFirstResponder];
    
    [[self amountTenderedText] resignFirstResponder];
    
    // ---------------------------------------------------------------------------------

    CGFloat amountTendered = [[[self amountTenderedText] text] floatValue];
    
    CGFloat purchasePrice = [[[self purchasePriceText] text] floatValue];
    
    // ---------------------------------------------------------------------------------
    
    if (amountTendered < purchasePrice) {
        
        [[self summaryLabel] setText:@"ERROR"];
    }
    else if (amountTendered == purchasePrice) {
        
        [[self summaryLabel] setText:@"ZERO"];
    }
    else {
    
        // -----------------------------------------------------------------------------
        
        [[self summaryLabel] setText:[NSString stringWithFormat:@"%.2f - %.2f = %.2f", amountTendered, purchasePrice,
                                      (amountTendered - purchasePrice)]];
        
        [[self answerLabel] setText:[self performTransaction:purchasePrice withAmount:amountTendered]];
        
        // -----------------------------------------------------------------------------
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
	
    [[self purchasePriceText] becomeFirstResponder];
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSString *)performTransaction:(CGFloat)purchasePrice withAmount:(CGFloat)amount {
    
    // ---------------------------------------------------------------------------------
    
    NSString *result;
    
    // ---------------------------------------------------------------------------------
    
    if (amount < purchasePrice) {
        
        result = @"ERROR";
    }
    else if (amount == purchasePrice) {
        
        result = @"ZERO";
    }
    else {
        
        // -----------------------------------------------------------------------------
        
        // convert the change
        
        result = [self convertChange:(amount - purchasePrice)];
        
        // -----------------------------------------------------------------------------
    }
    
    // ---------------------------------------------------------------------------------
    
    return result;
    
    // ---------------------------------------------------------------------------------
}

- (NSString *)convertChange:(CGFloat)change {
    
    // ---------------------------------------------------------------------------------
    
    NSString *retVal = @"";
    
    // ---------------------------------------------------------------------------------
    
    double intPart;
    
    CGFloat fractPart = modf(change, &intPart);
    
    // ---------------------------------------------------------------------------------
    
    int dollars = intPart;
    
    int hundred = dollars / 100;
    int fifty = dollars % 100 / 50;
    int twenty = dollars % 100 % 50 / 20;
    int ten = dollars % 100 % 50 % 20 / 10;
    int five = dollars % 100 % 50 % 20 % 10 / 5;
    int one = dollars % 100 % 50 % 20 % 10 % 5 / 1;
    
    // ---------------------------------------------------------------------------------
    
    if (hundred > 0) {
        
        retVal = [retVal stringByAppendingFormat:@"HUNDRED(%d), ", hundred];
    }
    
    if (fifty > 0) {
        
        retVal = [retVal stringByAppendingFormat:@"FIFTY(%d), ", fifty];
    }
    
    if (twenty > 0) {
        
        retVal = [retVal stringByAppendingFormat:@"TWENTY(%d), ", twenty];
    }
    
    if (ten > 0) {
        
        retVal = [retVal stringByAppendingFormat:@"TEN(%d), ", ten];
    }
    
    if (five > 0) {
        
        retVal = [retVal stringByAppendingFormat:@"FIVE(%d), ", five];
    }
    
    if (one > 0) {
        
        retVal = [retVal stringByAppendingFormat:@"ONE(%d), ", one];
    }
    
    // ---------------------------------------------------------------------------------
    
    int cents = fractPart * 100;
    
    int halfDollars = cents / 50;
    int quarters = cents % 50 / 25;
    int dimes = cents % 50  % 25 / 10;
    int nickels = cents % 50 % 25 % 10 / 5;
    int pennies = cents  % 50 % 25 % 10 % 5;
    
    if (halfDollars > 0) {
        
        retVal = [retVal stringByAppendingFormat:@"HALF DOLLAR(%d), ", halfDollars];
    }
    
    if (quarters > 0) {
        
        retVal = [retVal stringByAppendingFormat:@"QUARTERS(%d), ", quarters];
    }
    
    if (dimes > 0) {
        
        retVal = [retVal stringByAppendingFormat:@"DIMES(%d), ", dimes];
    }
    
    if (nickels > 0) {
        
        retVal = [retVal stringByAppendingFormat:@"NICKLES(%d), ", nickels];
    }
    
    if (pennies > 0) {
        
        retVal = [retVal stringByAppendingFormat:@"PENNIES(%d), ", pennies];
    }
    
    // ---------------------------------------------------------------------------------
    
    int length = [retVal length];
    
    if (length > 0) {
        
        NSString *trash = [retVal substringFromIndex:length - 2];
        
        if ([trash isEqualToString:@", "]) {
            
            retVal = [retVal substringToIndex:[retVal length] - 2];
        }
    }
    
    // ---------------------------------------------------------------------------------
    
    return retVal;
    
    // ---------------------------------------------------------------------------------
}

@end
