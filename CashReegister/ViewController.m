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
float purchasePrice=0;
float cashInHand=0;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

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
-(IBAction)change:(id)sender
{
    purchasePrice=[PP.text floatValue];
    cashInHand=[CH.text floatValue];
    CashRegister *cashRegister =[[CashRegister alloc] init];
   // NSLog(@"This is the number:%f,%f",purchasePrice,cashInHand);
    [resultView setText:[cashRegister first:purchasePrice second:cashInHand]];
   // NSLog(@"%@",[cashRegister first:purchasePrice second:cashInHand]);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Any additional checks to ensure you have the correct textField here.
    [textField resignFirstResponder];
}
@end
