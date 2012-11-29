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
@property (nonatomic, weak) IBOutlet UILabel *resultLabel;

- (NSString *)validatePaymentAmount;

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
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSString *)validatePaymentAmount
{
    NSLog(@"validatePaymentAmount");
    return @"";
}

- (IBAction)distributeChange:(id)sender
{
    NSLog(@"distributeChange");
    [[self view] endEditing:YES];
    [[self resultLabel] setTextAlignment:NSTextAlignmentCenter];
    [[self resultLabel] setText:@"wiring up"];
}

#pragma mark - === TEXT FIELD DELEGATE METHODS === -
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [[self resultLabel] setText:@""];
    return YES;
}

@end
