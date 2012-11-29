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
@property (nonatomic, strong) NSMutableArray *cashRegisterCurrencyArray;

// ui
@property (nonatomic, weak) IBOutlet UITextField *purchasePriceTextField;
@property (nonatomic, weak) IBOutlet UITextField *paymentAmountTextField;
@property (nonatomic, weak) IBOutlet UIButton *calculateButton;
@property (nonatomic, weak) IBOutlet UILabel *resultLabel;

- (NSString *)validatePaymentAmount;
- (BOOL)updateButtonStatusForPurchasePrice:(float)price andPaymentAmount:(float)payment;

@end

@implementation ViewController

@synthesize cashRegisterCurrencyArray;
@synthesize purchasePrice;
@synthesize paymentAmount;

#pragma mark - === VIEW CONTROLLER LIFECYCLE === -
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self purchasePriceTextField] setTag:0];
    [[self paymentAmountTextField] setTag:1];
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
    }
}

#pragma mark - === TEXT FIELD DELEGATE METHODS === -
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // reset message field
    [[self resultLabel] setText:@""];

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

// for future use to enable and disable button
- (BOOL)updateButtonStatusForPurchasePrice:(float)price andPaymentAmount:(float)payment
{
    if (price > 0 && payment > 0) {
        return YES;
    }
    
    return NO;
}

@end
