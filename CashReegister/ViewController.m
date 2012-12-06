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
    self.scrollHeight = 0;
    self.arrCurrency = [[NSArray alloc]initWithObjects:
    [self getCurrencyWithValue:100.00 andIdentify:@"ONE HUNDRED"],
    [self getCurrencyWithValue:50.00 andIdentify:@"FIFTY"],
    [self getCurrencyWithValue:20.00 andIdentify:@"TWENTY"],
    [self getCurrencyWithValue:10.00 andIdentify:@"TEN"],
    [self getCurrencyWithValue:5.00 andIdentify:@"FIVE"],
    [self getCurrencyWithValue:2.00 andIdentify:@"TWO"],
    [self getCurrencyWithValue:1.00 andIdentify:@"ONE"],
    [self getCurrencyWithValue:0.50 andIdentify:@"HALF DOLLAR"],
    [self getCurrencyWithValue:0.25 andIdentify:@"QUARTER"],
    [self getCurrencyWithValue:0.10 andIdentify:@"DIME"],
    [self getCurrencyWithValue:0.05 andIdentify:@"NICKEL"],
    [self getCurrencyWithValue:0.01 andIdentify:@"PENNY"],nil];
    //if you can see this, initial commit worked

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(Currency*)getCurrencyWithValue:(float)v andIdentify:(NSString*)s
{
    Currency *c = [[Currency alloc]init];
    c.value = [NSNumber numberWithFloat:v];
    c.name = [NSString stringWithString:s];
    return c;
}


- (void)viewDidUnload
{
    [self setTxtPrice:nil];
    [self setTxtCash:nil];
    [self setScrChange:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(NSString*)convertNumber:(NSString*)input
{
    
    NSMutableCharacterSet *decimalAndDot = [NSMutableCharacterSet characterSetWithCharactersInString:@"."];
    [decimalAndDot formUnionWithCharacterSet:[NSCharacterSet decimalDigitCharacterSet]];
    NSString *formattedInput = [[input componentsSeparatedByCharactersInSet:[decimalAndDot invertedSet]]componentsJoinedByString:@""];
    NSMutableArray *decimalComponents = [NSMutableArray arrayWithArray: [formattedInput componentsSeparatedByString:@"."]];
    if([decimalComponents count] > 1)
    {
        NSArray *temp = [NSArray arrayWithObjects:[decimalComponents objectAtIndex:0],[decimalComponents objectAtIndex:1], nil];
        [decimalComponents removeObjectAtIndex:0];
        [decimalComponents replaceObjectAtIndex:0 withObject:[temp componentsJoinedByString:@"."]];
        formattedInput = [decimalComponents componentsJoinedByString:@""];
    }
    return formattedInput;
    
    //NSString *formattedPhone =[[input componentsSeparatedByCharactersInSet:[decimalAndDot invertedSet]]componentsJoinedByString:@""];
    

}


-(float)roundStringValue:(NSString*)s
{
    int temp = [s floatValue] * 100 + .5;
    float rounded = temp / 100;
    return rounded;
}

-(void)displayResults:(NSString*)s
{
    CGSize maximumLabelSize = CGSizeMake(320,9999);
    CGSize expectedLabelSize = [s sizeWithFont:[UIFont fontWithName:@"Helvetica" size:16] constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    UILabel *lblChange = [[UILabel alloc]initWithFrame:CGRectMake(0, self.scrollHeight, self.scrChange.frame.size.width, expectedLabelSize.height)];
    [lblChange setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [lblChange setText:s];
    [lblChange setNumberOfLines:0];
    [lblChange setLineBreakMode:NSLineBreakByWordWrapping];
    [self.scrChange addSubview:lblChange];
    self.scrollHeight = self.scrollHeight + 30 + lblChange.frame.size.height;
    [self.scrChange setContentSize:CGSizeMake(self.scrChange.frame.size.width, self.scrollHeight)];
}

- (IBAction)btnChange:(id)sender
{
    float price = [self roundStringValue: [self convertNumber:self.txtPrice.text]];
    float cash = [self roundStringValue: [self convertNumber:self.txtCash.text]];
    float owed = cash - price;
    if(owed > 0)
    {
        NSMutableString *allChange = [[NSMutableString alloc]initWithString:@""];
        for(Currency *c in self.arrCurrency)
        {
            BOOL done = NO;
            while(!done)
            {
                
                if(owed - [c.value floatValue] > 0)
                {
                    [allChange appendFormat:@", %@",c.name ];
                    owed = owed - [c.value floatValue];
                }
                else
                {
                    done = YES;
                }
            }
        }
        [self displayResults:allChange];
    }
    else if(owed == 0)
    {
        [self displayResults:@"Exact Change"];
    }
    else
    {
        [self displayResults:[NSString stringWithFormat:@"You still owe $%f more",-owed]];
    }
        
}
@end
