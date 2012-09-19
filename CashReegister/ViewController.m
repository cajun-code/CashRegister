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
@synthesize purchasePrice;
@synthesize cashHanded;
@synthesize purchasePriceLabel;
@synthesize cashHandedLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setPurchasePrice:nil];
    [self setCashHanded:nil];
    [self setPurchasePriceLabel:nil];
    [self setCashHandedLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (UIInterfaceOrientationIsPortrait(interfaceOrientation));
}

#pragma mark - Interface Builder Actions
- (IBAction)runTransaction:(id)sender 
{
    
}

@end
