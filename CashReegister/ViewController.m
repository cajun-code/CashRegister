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
#import "TransactionUtil.h"

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
    self.cashTransaction = [[BalanceTransaction alloc] init];
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
    self.txtDenomination.text = @"";
    [self.txtPurchasePrice resignFirstResponder];
    [self.txtCashGiven resignFirstResponder];
    if(self.txtCashGiven.text.length == 0 || self.txtPurchasePrice.text.length == 0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Please Enter" message:@"Please enter both purchase price and cash handed by the customer." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
        [self.txtPurchasePrice becomeFirstResponder];
        return;
    }
    BalanceOutput* trBalance = [self.cashTransaction calculateBalanceWithPrice:self.txtPurchasePrice.text andCachReceived:self.txtCashGiven.text];
    if(trBalance.isError)
    {
        [[[UIAlertView alloc] initWithTitle:@"Cach Handed" message:@"Please provide enough cash." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];  
        self.txtDenomination.text = @"ERROR";
        self.lblBalance.text = @"";
        return;
    }
    if([trBalance.output count] == 0)
    {
        [[[UIAlertView alloc] initWithTitle:@"No Balance" message:@"Both purchase price and cash handed are same." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
        self.lblBalance.text = [NSString stringWithFormat:@" Balance is 0.00" ];
        self.txtDenomination.text = @"ZERO";
        
        return;
    }
    [trBalance.output enumerateObjectsUsingBlock:^(Denomination* obj, NSUInteger idx, BOOL *stop) {
        NSLog(@" Currrency %f count %i",[obj.value floatValue],obj.count);
    }];
    if([trBalance.output count] > 1)
    {
        [trBalance.output sortUsingComparator:^NSComparisonResult(Denomination *obj1, Denomination *obj2) {
            return [obj1.title compare :obj2.title ];
        }];
    }
    __block NSMutableString* outPutStr = [NSMutableString string];
    
    [trBalance.output enumerateObjectsUsingBlock:^(Denomination* obj, NSUInteger idx, BOOL *stop) {
        NSLog(@" Currrency %@ count %i",obj.title ,obj.count);
        [outPutStr appendFormat:[NSString stringWithFormat:@"%@ %i \n",obj.title,obj.count]];
        //        outPutStr = [outPutStr stringByAppendingFormat:@"%@ %i \n",obj.title,obj.count];
    }];
    self.txtDenomination.text = outPutStr;
    self.lblBalance.text = [NSString stringWithFormat:@" Balance is %.2f", [trBalance.balance floatValue] ];
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
    //Update the show/hide labels based upon the inputs.
       
    if (sender.text.length == 0)
        return;
    
    
    //Format to currency.
    NSNumber *num = [[TransactionUtil getCurrencyFormatter]  numberFromString:sender.text];
    
    if(!num)
        num = [NSNumber numberWithDouble:[sender.text doubleValue]];
    
    NSString *str = [[TransactionUtil getCurrencyFormatter] stringFromNumber:num];
    sender.text = str;
    
    
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
