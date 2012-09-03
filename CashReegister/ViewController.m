//
//  ViewController.m
//  CashReegister
//
//  Created by Allan Davis on 8/22/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "ViewController.h"
#import "CashRegister.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize resultView;
@synthesize PP;
@synthesize CH;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CashRegister *cashRegister =[[CashRegister alloc] init];
    int purchasePrice=0;
    int cashInHand=0;
    purchasePrice=[PP.text intValue];
    cashInHand=[CH.text intValue];
    //[cashRegister first:purchasePrice second:cashInHand]);
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

@end
