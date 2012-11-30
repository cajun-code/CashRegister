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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)backgroundTapped:(id)sender {
    [self.productPrice resignFirstResponder];
    [self.cashRecived resignFirstResponder];
}

- (void)viewDidUnload
{
    [self setProductPrice:nil];
    [self setCashRecived:nil];
    
    [self setChangeLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)getChange:(id)sender {
    [self.productPrice resignFirstResponder];
    [self.cashRecived resignFirstResponder];
}
@end
