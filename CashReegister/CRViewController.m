//
//  CRViewController.m
//  CashReegister
//
//  Created by Brad Wiederholt on 11/16/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "CRViewController.h"

@interface CRViewController ()

@end

@implementation CRViewController

@synthesize changeButton, changeText, cashCollected, purchasePrice;


#pragma mark IBActions

- (IBAction)makeChange:(id)sender
{
    [self resignResponders];
    
    // For this exercise, no validation of view data.  Model ensures it's only working with reasonable data as it comes in.
    
    [self.registerModel setCashCollected:[NSDecimalNumber decimalNumberWithString:self.cashCollected.text]];
    [self.registerModel setPurchasePrice:[NSDecimalNumber decimalNumberWithString:self.purchasePrice.text]];
    self.changeText.text = [self.registerModel computeChangeAsString];
}


#pragma mark Keyboard Handling

-(void)touchesBegan :(NSSet *)touches withEvent:(UIEvent *)event
{
    [self resignResponders];
    [super touchesBegan:touches withEvent:event];
}

- (void)resignResponders
{
    [self.cashCollected resignFirstResponder];
    [self.purchasePrice resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark View Management

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.registerModel = [[CRRegisterModel alloc] init];
    
    // Load up a currency file and give it to the register model.
    NSBundle *applicationBundle = [NSBundle mainBundle];
    NSString *path = [applicationBundle pathForResource:@"CurrencyMapping" ofType:@"plist"];
    NSArray *arr = [[NSArray alloc] initWithContentsOfFile:path];
    
    [self.registerModel setCurrencyList:arr];
}

- (void)viewDidUnload
{
    self.registerModel = nil;
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
