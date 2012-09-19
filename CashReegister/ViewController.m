//
//  ViewController.m
//  CashReegister
//
//  Created by Allan Davis on 8/22/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "ViewController.h"
#import "KSTransaction.h"
#import "KSCashRegister.h"

@interface ViewController ()<UITextFieldDelegate>
@property(nonatomic, retain) NSNumberFormatter *formatter;
@property(nonatomic, retain) KSTransaction *transaction;
@end

@implementation ViewController
@synthesize purchasePrice;
@synthesize cashHanded;
@synthesize purchasePriceLabel;
@synthesize cashHandedLabel;
@synthesize formatter;
@synthesize transaction;

- (void)viewDidLoad
{
    self.title = @"Cash Register";    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.purchasePrice.textColor = self.cashHanded.textColor = [UIColor greenColor];
    self.purchasePrice.delegate = self.cashHanded.delegate = self;
    
    static NSNumberFormatter *format = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        format = [[NSNumberFormatter alloc] init]; 
        [format setNumberStyle:NSNumberFormatterCurrencyStyle]; 
    });
    
    self.formatter = format;
    
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

-(void) viewWillAppear:(BOOL)animated
{
    //Initial Setup.
    self.purchasePriceLabel.hidden =  self.cashHandedLabel.hidden = YES;
    self.purchasePrice.text = @"";
    self.cashHanded.text = @"";    
    [super viewWillAppear:animated];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (UIInterfaceOrientationIsPortrait(interfaceOrientation));
}

#pragma mark - Interface Builder Actions
- (IBAction)runTransaction:(id)sender 
{
    [self.cashHanded resignFirstResponder];
    [self.purchasePrice resignFirstResponder];
    NSNumber *pp = [self.formatter numberFromString:self.purchasePrice.text];   
    if (!pp)
        pp = [NSNumber numberWithDouble:self.purchasePrice.text.doubleValue];
    
    NSNumber *ch = [self.formatter numberFromString:self.cashHanded.text];
    if(!ch)
        ch = [NSNumber numberWithDouble:self.cashHanded.text.doubleValue];
    
    if(self.cashHanded.text.length == 0 || self.purchasePrice.text.length == 0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter both purchase price and cash handed by the customer." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
        return;
    }
    
    @try 
    {
        KSTransaction *txn = [KSCashRegister transactionWithCashHanded:ch.floatValue andPurchasePrice:pp.floatValue];
        if (txn.output.count == 0) 
        {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Error running your transaction. Please check check the input and try again." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
        }
        else 
        {
            self.transaction = txn;
            NSLog(@"%@",txn.output);
        }
    }
    @catch (NSException *exception) 
    {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Error running your transaction. Please check check the input and try again." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
    }
    
}

@end
