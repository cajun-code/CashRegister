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

//set up initial values, construct array of currency
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

//convert any string to a valid number
-(NSString*)convertNumber:(NSString*)input
{
    NSMutableCharacterSet *decimalAndDot = [NSMutableCharacterSet characterSetWithCharactersInString:@"."];
    [decimalAndDot formUnionWithCharacterSet:[NSCharacterSet decimalDigitCharacterSet]];
    NSString *formattedInput = [[input componentsSeparatedByCharactersInSet:[decimalAndDot invertedSet]]componentsJoinedByString:@""];
    NSMutableArray *decimalComponents = [NSMutableArray arrayWithArray: [formattedInput componentsSeparatedByString:@"."]];
    
    //if there is at least one decimal point
    if([decimalComponents count] > 1)
    {
        NSArray *temp = [NSArray arrayWithObjects:[decimalComponents objectAtIndex:0],[decimalComponents objectAtIndex:1], nil];
        [decimalComponents removeObjectAtIndex:0];
        [decimalComponents replaceObjectAtIndex:0 withObject:[temp componentsJoinedByString:@"."]];
        formattedInput = [decimalComponents componentsJoinedByString:@""];
    }
    return formattedInput;
}

//round it to 2 decimal places
-(float)roundStringValue:(NSString*)s
{
    int temp = ([s floatValue] * 100 + .5);
    float rounded = temp;
    rounded = rounded/100;
    return rounded;
}

//print string to scrollView
-(void)displayResults:(NSString*)s
{
    CGSize maximumLabelSize = CGSizeMake(320,9999);
    CGSize expectedLabelSize = [s sizeWithFont:[UIFont fontWithName:@"Helvetica" size:16] constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    UILabel *lblChange = [[UILabel alloc]initWithFrame:CGRectMake(5, self.scrollHeight, self.scrChange.frame.size.width-10, expectedLabelSize.height)];
    [lblChange setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [lblChange setText:s];
    [lblChange setNumberOfLines:0];
    [lblChange setLineBreakMode:NSLineBreakByWordWrapping];
    [self.scrChange addSubview:lblChange];
    self.scrollHeight = self.scrollHeight + 30 + lblChange.frame.size.height;
    [self.scrChange setContentSize:CGSizeMake(self.scrChange.frame.size.width, self.scrollHeight)];
    
    int position = 0;
    
    //if the user could scroll, scroll to the bottom
    if(self.scrChange.contentSize.height > self.scrChange.frame.size.height)
    {
        position = self.scrChange.contentSize.height - self.scrChange.frame.size.height;
    }
    
    [self.scrChange setContentOffset:CGPointMake(0, position) animated:YES];
}


//when the user presses the change button
- (IBAction)btnChange:(id)sender
{
    [self.txtPrice resignFirstResponder];
    [self.txtCash resignFirstResponder];
    float price = [self roundStringValue: [self convertNumber:self.txtPrice.text]];
    [self.txtPrice setText:[NSString stringWithFormat:@"%.2f",price]];
    float cash = [self roundStringValue: [self convertNumber:self.txtCash.text]];
    [self.txtCash setText:[NSString stringWithFormat:@"%.2f",cash]];
    float owed = cash - price;
    
    
    //if they gave more cash than the price
    if(owed > 0)
    {
        NSMutableString *allChange = [[NSMutableString alloc]initWithString:@""];
        
        //for each unit of currency in order from greatest to least money
        for(Currency *c in self.arrCurrency)
        {
            BOOL done = NO;
            //while this unit is still less than the total owed
            while(!done)
            {
                //if this unit is still less than the total owed
                if(owed - [c.value floatValue] >= 0)
                {
                    NSLog(@"thing: %@, amount left: %f",c.name,owed);
                    [allChange appendFormat:@"%@,",c.name ];
                    owed = owed - [c.value floatValue];
                    
                }
                //or it it's not, move onto the next lowest unit
                else
                {
                    done = YES;
                }
            }
        }
        [allChange deleteCharactersInRange:NSMakeRange([allChange length]-1, 1)];
        [self displayResults:allChange];
    }
    //or if they gave exact change
    else if(owed == 0)
    {
        [self displayResults:@"ZERO"];
    }
    //or if they didn't give enough money
    else
    {
        [self displayResults:@"ERROR"];
    }
        
}
@end
