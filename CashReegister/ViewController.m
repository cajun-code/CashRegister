//
//  ViewController.m
//  CashReegister
//
//  Created by Allan Davis on 8/22/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// model
@property (nonatomic) float purchasePrice;
@property (nonatomic) float paymentAmount;
@property (nonatomic, strong) NSMutableArray *changeArray;
@property (nonatomic, strong) NSMutableDictionary *currencyDictionary;

// ui
@property (nonatomic, weak) IBOutlet UITextField *purchasePriceTextField;
@property (nonatomic, weak) IBOutlet UITextField *paymentAmountTextField;
@property (nonatomic, weak) IBOutlet UIButton *calculateButton;
@property (nonatomic, weak) IBOutlet UILabel *resultLabel;

- (NSString *)validatePaymentAmount;
- (BOOL)updateButtonStatusForPurchasePrice:(float)price andPaymentAmount:(float)payment;
- (void)setupCurrencies;
- (NSString *)findLargestCurrencyForAmount:(float)amount;

@end

@implementation ViewController

// model
@synthesize purchasePrice;
@synthesize paymentAmount;
@synthesize changeArray;
@synthesize currencyDictionary;

// ui
@synthesize purchasePriceTextField;
@synthesize paymentAmountTextField;
@synthesize calculateButton;
@synthesize resultLabel;

#pragma mark - === VIEW CONTROLLER LIFECYCLE === -
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupCurrencies];
    [[self purchasePriceTextField] setTag:0];
    [[self paymentAmountTextField] setTag:1];
    changeArray = [[NSMutableArray alloc] init];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSString *)validatePaymentAmount
{
    NSLog(@"validatePaymentAmount");

    // negative or zero value
    if ([self paymentAmount] <= 0)
    {
        return @"ERROR";
    }

    // negative or zero value
    if ([self purchasePrice] <= 0)
    {
        return @"ERROR";
    }

    // payment amount is less than purchase price
    if ([self paymentAmount] < [self purchasePrice])
    {
        return @"ERROR";
    }
    
    return @"";
}

- (IBAction)distributeChange:(id)sender
{
    NSLog(@"distributeChange");
    [changeArray removeAllObjects];

    [[self view] endEditing:YES];
    [[self resultLabel] setTextAlignment:NSTextAlignmentLeft];

    // validate
    NSString *validationMessage = [self validatePaymentAmount];

    if ([validationMessage length] > 0)
    {
        [[self resultLabel] setTextColor:[UIColor redColor]];
        [[self resultLabel] setText:validationMessage];

        return;
    }

    // if we've reached here, calculate the change
    if (paymentAmount == purchasePrice)
    {
        [[self resultLabel] setTextColor:[UIColor blackColor]];
        [[self resultLabel] setText:@"ZERO"];
        
        return;
    }
    // calculate the change
    else
    {
        float change = paymentAmount - purchasePrice;

        NSLog(@"change: %.2f", change);
        
        float runningChange = change;
        
        while (runningChange > 0)
        {
            
            NSString *currencyString = [self findLargestCurrencyForAmount:runningChange];
            
            float currencyValue = [[currencyDictionary valueForKey:currencyString] floatValue];
            
            if (currencyValue > 0)
            {
                runningChange = runningChange - currencyValue;
                [changeArray addObject:currencyString];
            }
            else
            {
                // safety check
                break;
            }
        }

        // sort result array alphabetically
        NSArray *resultArray = (NSMutableArray *)[changeArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

        // display string
        NSString *displayString = [[resultArray valueForKey:@"description"] componentsJoinedByString:@","];
        //NSLog(@"%@", displayString);

        [[self resultLabel] setTextColor:[UIColor blackColor]];
        [[self resultLabel] setText:displayString];
    }
}

#pragma mark - === TEXT FIELD DELEGATE METHODS === -
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // reset message field
    [[self resultLabel] setText:@""];

    // limit to numbers and decimal point
    NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];

    // handle backspace
    if ([string length] == 0)
    {
        NSString *amount = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        // update float values
        if ([textField tag] == 0)
        {
            purchasePrice = [amount floatValue];
        }
        else if ([textField tag] == 1)
        {
            paymentAmount = [amount floatValue];
        }

        return YES;
    }
    else if ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0)
    {
        NSString *amount = [textField.text stringByReplacingCharactersInRange:range withString:string];

        // update float values
        if ([textField tag] == 0)
        {
            purchasePrice = [amount floatValue];
        }
        else if ([textField tag] == 1)
        {
            paymentAmount = [amount floatValue];
        }

        //BOOL isButtonEnabled = [self updateButtonStatusForPurchasePrice:purchasePrice andPaymentAmount:paymentAmount];
        //[[self calculateButton] setEnabled:isButtonEnabled];

        return YES;
    }

    return NO;
}

- (void)setupCurrencies
{
    currencyDictionary = [[NSMutableDictionary alloc] init];

    [currencyDictionary setValue:[NSNumber numberWithFloat:0.01f] forKey:@"PENNY"];
    [currencyDictionary setValue:[NSNumber numberWithFloat:0.05f] forKey:@"NICKEL"];
    [currencyDictionary setValue:[NSNumber numberWithFloat:0.10f] forKey:@"DIME"];
    [currencyDictionary setValue:[NSNumber numberWithFloat:0.25f] forKey:@"QUARTER"];
    [currencyDictionary setValue:[NSNumber numberWithFloat:0.50f] forKey:@"HALF DOLLAR"];
    [currencyDictionary setValue:[NSNumber numberWithFloat:1.00f] forKey:@"ONE"];
    [currencyDictionary setValue:[NSNumber numberWithFloat:2.00f] forKey:@"TWO"];
    [currencyDictionary setValue:[NSNumber numberWithFloat:5.00f] forKey:@"FIVE"];
    [currencyDictionary setValue:[NSNumber numberWithFloat:10.00f] forKey:@"TEN"];
    [currencyDictionary setValue:[NSNumber numberWithFloat:20.00f] forKey:@"TWENTY"];
    [currencyDictionary setValue:[NSNumber numberWithFloat:50.00f] forKey:@"FIFTY"];
    [currencyDictionary setValue:[NSNumber numberWithFloat:100.00f] forKey:@"ONE HUNDRED"];
}

- (NSString *)findLargestCurrencyForAmount:(float)amount
{
    // sort by largest amount
    NSArray *sortedValuesArray = [currencyDictionary keysSortedByValueUsingSelector:@selector(compare:)];
    sortedValuesArray = [[sortedValuesArray reverseObjectEnumerator] allObjects];

    for (int i=0; i < [sortedValuesArray count]; i++)
    {
        float currencyAmount = [[currencyDictionary valueForKey:[sortedValuesArray objectAtIndex:i]] floatValue];
        NSLog(@"%.2f", amount - currencyAmount);
        
        // account for rounding error potential
        int currencyAmountInteger = currencyAmount * 100;
        int amountInteger = amount * 100;
        
        if (amountInteger - currencyAmountInteger >= 0)
        {
            return [sortedValuesArray objectAtIndex:i];
        }
    }

    return @"";
}

// for future use to enable and disable button
- (BOOL)updateButtonStatusForPurchasePrice:(float)price andPaymentAmount:(float)payment
{
    if (price > 0 && payment > 0) {
        return YES;
    }
    
    return NO;
}

@end
