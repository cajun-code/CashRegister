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
@synthesize cashregister = _cashregister;
@synthesize arrCashback = _arrCashback;


// getters and setters
-(CashReegisterCalculator *) cashregister
{
    if (!_cashregister)
    {
        _cashregister = [[CashReegisterCalculator alloc] initWithDefaultCashRoll];
    }
    return _cashregister;
}

-(NSArray *) arrCashback
{
    if (!_arrCashback)
    {
        _arrCashback = [[NSArray alloc] init];
    }
    return _arrCashback;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    self.uilblCashInRegister.text = [NSString stringWithFormat:@"%.2f", [self.cashregister totalCashInRoll]];
}

- (void)viewDidUnload
{
    [self setTableviewChange:nil];
    [self setUitxtPurchasePrice:nil];
    [self setUitxtCashGiven:nil];
    [self setUilblCashInRegister:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

// UITableViewDataSource Delegate Messages

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Total Cash Back: $%.2f", [CashReegisterCalculator totalCashBackFromCashBackList:self.arrCashback]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrCashback count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CashReegisterCalculator cellCacheIdentifier]];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[CashReegisterCalculator cellCacheIdentifier]];
    }
    
    id details = [[self.arrCashback objectAtIndex:indexPath.row] objectAtIndex:1];
    if ( [details isKindOfClass:[NSString class]] )
    {
        cell.textLabel.text = [[self.arrCashback objectAtIndex:indexPath.row] objectAtIndex:0];  // that's the description of the denomination
        cell.detailTextLabel.text = details;
    }
    else if ( [details isKindOfClass:[NSNumber class]] )
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@%@ back", details, [[self.arrCashback objectAtIndex:indexPath.row] objectAtIndex:0], ([details intValue] == 1 ? @"" : @"S")];  // that's the description of the denomination and the quanity
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f dollars", [[[self.arrCashback objectAtIndex:indexPath.row] objectAtIndex:2] floatValue]];
    }
    return cell;
 
}

- (IBAction)showCashBack:(UIButton *)sender
{
    [self.uitxtCashGiven resignFirstResponder];
    [self.uitxtPurchasePrice resignFirstResponder];
    
    self.arrCashback = [[NSArray alloc] initWithArray:[self.cashregister cashBackForPurchasePrice:[self.uitxtPurchasePrice.text floatValue] andCashGiven:[self.uitxtCashGiven.text floatValue]]];
    

    self.uilblCashInRegister.text = [NSString stringWithFormat:@"%.2f", [self.cashregister totalCashInRoll]];
    [self.tableviewChange reloadData];
}

- (IBAction)resreshRegister:(UIButton *)sender
{
    [self.cashregister loadWithDefaultCashRoll];
    self.arrCashback = nil;
    self.uilblCashInRegister.text = [NSString stringWithFormat:@"%.2f", [self.cashregister totalCashInRoll]];
    [self.tableviewChange reloadData];
}

- (IBAction)editingChangedOnCurrencyTextField:(UITextField *)sender
{
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    
    if ([string isEqualToString:@"."])// do not allow more than one than one decimal
    {
        NSRange rangeOfExistingDecimal = [textField.text rangeOfString:@"."];
        if (rangeOfExistingDecimal.location != NSNotFound )
        {
            return NO;
        }
    }
    NSString *newValue = [[textField text] stringByReplacingCharactersInRange:range withString:string];
    newValue = [[newValue componentsSeparatedByCharactersInSet:nonNumberSet] componentsJoinedByString:@""];
    
    if (![newValue isEqualToString:@"."])            // right now, for dollars, only allow to decimals.
    {
        NSRange rangeOfDecimal = [newValue rangeOfString:@"."];
        if (rangeOfDecimal.location != NSNotFound && (rangeOfDecimal.location+1) < [newValue length]-2)
        {
            return NO;
        }
    }
    
    textField.text = newValue;

    return NO;  // override, so don't return YES;
}

@end
