//
//  ViewController.m
//  CashReegister
//
//  Created by Allan Davis on 8/22/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "ViewController.h"
#import "BalanceTransaction.h"
#import "BalanceOutput.h"
#import "Denomination.h"

@interface ViewController ()<UITextFieldDelegate>
@property(nonatomic, strong) BalanceTransaction* cashTransaction;

@end

@implementation ViewController

@synthesize txtPurchasePrice;
@synthesize txtCashGiven;
@synthesize lblBalance;
@synthesize txtDenomination;

@synthesize cashTransaction;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTxtPurchasePrice:nil];
    [self setTxtCashGiven:nil];
    [self setLblBalance:nil];
    [self setTxtDenomination:nil];
    [self setCashTransaction:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


//Supporting only Portrait Orientation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (UIInterfaceOrientationIsPortrait(interfaceOrientation));
}

- (IBAction)runTransaction:(UIButton *)sender 
{
   
}


#pragma mark - UITextFieldDelegate Methods.
- (BOOL)textField:(UITextField *)sender shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *numberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    
    NSString *finalString =[sender.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([finalString rangeOfCharacterFromSet:numberSet].location != NSNotFound) 
        return NO;
    
    NSArray *comps = [finalString componentsSeparatedByString:@"."];
    
    if (comps.count > 2) 
        return NO;
    
    if(comps.count == 2)
    {
        NSString *decimal  = [comps objectAtIndex:1];
        if (decimal.length > 2)
            return NO;
    }
    return YES;    
}

- (void)textFieldDidEndEditing:(UITextField *)sender
{
    
    
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //Handle next and done buttons.
    if (textField == self.txtPurchasePrice) 
        [self.txtCashGiven becomeFirstResponder];
    
    [textField resignFirstResponder];
    
    return YES;
}
@end
