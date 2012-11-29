//
//  ViewController.m
//  CashReegister
//
//  Created by Allan Davis on 8/22/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *cashRegisterCurrencyArray;
@property (nonatomic) float purchasePrice;
@property (nonatomic) float paymentAmount;

- (NSString *)validatePaymentAmount;
- (void)distributeChange;

@end

@implementation ViewController

@synthesize cashRegisterCurrencyArray;
@synthesize purchasePrice;
@synthesize paymentAmount;

#pragma mark - === VIEW CONTROLLER LIFECYCLE === -
- (void)viewDidLoad
{
    [super viewDidLoad];
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

- (void)distributeChange
{
    NSLog(@"distributeChange");
}

@end
