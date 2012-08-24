//
//  DFViewController.m
//  cashRegister
//
//  Created by unbounded solutions on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DFViewController.h"

@interface DFViewController ()

@end

@implementation DFViewController
@synthesize pathField;
@synthesize outputField;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setPathField:nil];
    [self setOutputField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

-(void)processInputFileForPath:(NSString *)inputFilePath
{
    NSError * error;
    
    // Convert path to NSURL
    NSURL * inputURL = [NSURL URLWithString:inputFilePath];
    
    // Grab the file
    NSString * inputFile = [NSString stringWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:&error];
    
    // Display error if input file cant be found
    if (!inputFile) {
        [outputField setText:@"Error with file path."];
        return;
    }
    
    // Prepare output string
    NSMutableString * output = [NSMutableString stringWithString:@"\n"];
    
    // Go through each line of the input file and execute this block
    [inputFile enumerateLinesUsingBlock:^(NSString *line, BOOL *stop) {
        
        // Find the semicolon
        NSRange semicolonRange = [line rangeOfString:@";"];
        
        // Only process lines that contain semicolons
        if (semicolonRange.location != NSNotFound) {
            // block for left side of semicolon, or purchase price
            NSString * purchasePrice = [line substringWithRange:NSMakeRange(0, semicolonRange.location)];
            
            
            
            // block for right side of colon, or cash tendered
            
            // Move index past the semicolon
            int cashLocation = semicolonRange.location + 1;
            NSString * cash = [line substringWithRange:NSMakeRange(cashLocation, line.length-cashLocation)];
            
            
            // comparison of purchase price and cash
            
            // turn cash text into an NSDecimalNumber for comparison and precision
            NSDecimalNumber * cashNumber = [NSDecimalNumber decimalNumberWithDecimal:[NSNumber numberWithFloat:cash.floatValue].decimalValue];
            
            // turn purchase price text into a NSDecimalNumber for comparison and precision
            NSDecimalNumber * purchasePriceNumber = [NSDecimalNumber decimalNumberWithDecimal:[NSNumber numberWithFloat:purchasePrice.floatValue].decimalValue];
            
            // Compare cash to purchase price
            NSComparisonResult changeResult = [cashNumber compare:purchasePriceNumber];
            
            // Check the result
            switch (changeResult) {
                // Append 'ZERO' if cash is same as purchase price
                case NSOrderedSame:
                    [output appendString:@"ZERO\n\n"];
                    break;
                // subtract purchase price from cash if cash is greater,
                // then convert the number to strings by calling
                // changeStringForChange:(NSDecimalNumber*)change
                case NSOrderedDescending:
                    [output appendFormat:@"%@\n\n", [self changeStringForChange:[cashNumber decimalNumberBySubtracting:purchasePriceNumber]]];  
                    break;
                // append 'ERROR' if cash is less than purchase price
                case NSOrderedAscending:
                    [output appendString:@"ERROR\n\n"];
                    break;
                default:
                    break;
            }

        }
    }];
    
    // Display output in text view
    [outputField setText:output];
}

-(NSString*)changeStringForChange:(NSDecimalNumber*)changeNumber
{
    // Prepare string to hold all entries for a line
    NSMutableString * changeString = [[NSMutableString alloc] init];

    // set up for division to see how many of each currency to use
    NSDecimalNumberHandler * handler = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    

    // Check for One Hundred Dollar bills by comparing change amount to 100
    NSComparisonResult hundredDollarResult = [changeNumber compare:[NSNumber numberWithFloat:100.0]];
    switch (hundredDollarResult) {
        // Same as change >= 100
        case NSOrderedSame:
        case NSOrderedDescending:
        {
            // divide by 100, and append that many bills to the string
            NSDecimalNumber * hundred = [NSDecimalNumber decimalNumberWithDecimal:[NSNumber numberWithInt:100].decimalValue];
            NSDecimalNumber * hundredsCount = [changeNumber decimalNumberByDividingBy:hundred withBehavior:handler];
            int hundreds = hundredsCount.intValue;
            while (hundreds > 0) {
                [changeString appendString:@"ONE HUNDRED,"];
                changeNumber = [changeNumber decimalNumberBySubtracting:hundred];
                hundreds--;
            } 
        }
            break;
            
        default:
            break;
    }
    
    // Check for Fifty Dollar bills
    NSComparisonResult fiftyDollarResult = [changeNumber compare:[NSNumber numberWithFloat:50.0]];
    switch (fiftyDollarResult) {
        case NSOrderedSame:
        case NSOrderedDescending:
        {
            // divide by 50, and append that many bills to the string
            NSDecimalNumber * fifty = [NSDecimalNumber decimalNumberWithDecimal:[NSNumber numberWithInt:50].decimalValue];
            NSDecimalNumber * fiftyCount = [changeNumber decimalNumberByDividingBy:fifty withBehavior:handler];
            int fifties = fiftyCount.intValue;
            while (fifties > 0) {
                [changeString appendString:@"FIFTY,"];
                changeNumber = [changeNumber decimalNumberBySubtracting:fifty];
                fifties--;
            }  
        }
            break;
            
        default:
            break;
    }
    
    // Check for Twenty Dollar bills
    NSComparisonResult twentyDollarResult = [changeNumber compare:[NSNumber numberWithFloat:20.0]];
    switch (twentyDollarResult) {
        case NSOrderedSame:
        case NSOrderedDescending:
        {
            // divide by 20, and append that many bills to the string
            NSDecimalNumber * twenty = [NSDecimalNumber decimalNumberWithDecimal:[NSNumber numberWithInt:20].decimalValue];
            NSDecimalNumber * twentiesCount = [changeNumber decimalNumberByDividingBy:twenty withBehavior:handler];
            int twenties = twentiesCount.intValue;
            while (twenties > 0) {
                [changeString appendString:@"TWENTY,"];
                changeNumber = [changeNumber decimalNumberBySubtracting:twenty];
                twenties--;
            }    
        }
            break;
            
        default:
            break;
    }
    
    // Check for Ten Dollar bills
    NSComparisonResult tenDollarResult = [changeNumber compare:[NSNumber numberWithFloat:10.0]];
    switch (tenDollarResult) {
        case NSOrderedSame:
        case NSOrderedDescending:
        {
            // divide by 10, and append that many bills to the string
            NSDecimalNumber * ten = [NSDecimalNumber decimalNumberWithDecimal:[NSNumber numberWithInt:10].decimalValue];
            NSDecimalNumber * tensCount = [changeNumber decimalNumberByDividingBy:ten withBehavior:handler];
            int tens = tensCount.intValue;
            while (tens > 0) {
                [changeString appendString:@"TEN,"];
                changeNumber = [changeNumber decimalNumberBySubtracting:ten];
                tens--;
            }     
        }
            break;
            
        default:
            break;
    }

    // Check for Five Dollar bills
    NSComparisonResult fiveDollarResult = [changeNumber compare:[NSNumber numberWithFloat:5.0]];
    switch (fiveDollarResult) {
        case NSOrderedSame:
        case NSOrderedDescending:
        {
            // divide by 5, and append that many bills to the string
            NSDecimalNumber * five = [NSDecimalNumber decimalNumberWithDecimal:[NSNumber numberWithInt:5].decimalValue];
            NSDecimalNumber * fivesCount = [changeNumber decimalNumberByDividingBy:five withBehavior:handler];
            int fives = fivesCount.intValue;
            while (fives > 0) {
                [changeString appendString:@"FIVE,"];
                changeNumber = [changeNumber decimalNumberBySubtracting:five];
                fives--;
            }      
        }
            break;
            
        default:
            break;
    }
    
    
    // Check for Two Dollar bills
    NSComparisonResult twoDollarResult = [changeNumber compare:[NSNumber numberWithFloat:2.0]];
    switch (twoDollarResult) {
        case NSOrderedSame:
        case NSOrderedDescending:
        {
            // divide by 2, and append that many bills to the string
            NSDecimalNumber * two = [NSDecimalNumber decimalNumberWithDecimal:[NSNumber numberWithInt:2].decimalValue];
            NSDecimalNumber * twosCount = [changeNumber decimalNumberByDividingBy:two withBehavior:handler];
            int twos = twosCount.intValue;
            while (twos > 0) {
                [changeString appendString:@"TWO,"];
                changeNumber = [changeNumber decimalNumberBySubtracting:two];
                twos--;
            }        
        }
            break;
            
        default:
            break;
    }
    
    // Check for One Dollar bills
    NSComparisonResult dollarResult = [changeNumber compare:[NSNumber numberWithFloat:1.0]];
    switch (dollarResult) {
        case NSOrderedSame:
        case NSOrderedDescending:
        {
            // divide by 1, and append that many bills to the string
            NSDecimalNumber * one = [NSDecimalNumber decimalNumberWithDecimal:[NSNumber numberWithInt:1].decimalValue];
            NSDecimalNumber * onesCount = [changeNumber decimalNumberByDividingBy:one withBehavior:handler];
            int ones = onesCount.intValue;
            while (ones > 0) {
                [changeString appendString:@"ONE,"];
                changeNumber = [changeNumber decimalNumberBySubtracting:one];
                ones--;
            }          
        }
            break;
            
        default:
            break;
    }
    
    // Check for Quarters
    NSComparisonResult quarterResult = [changeNumber compare:[NSNumber numberWithFloat:.25]];
    switch (quarterResult) {
        case NSOrderedSame:
        case NSOrderedDescending:
        {
            // divide by .25, and append that many quarters to the string
            NSDecimalNumber * quarter = [NSDecimalNumber decimalNumberWithDecimal:[NSNumber numberWithFloat:.25].decimalValue];
            NSDecimalNumber * quartersCount = [changeNumber decimalNumberByDividingBy:quarter withBehavior:handler];
            int quarters = quartersCount.intValue;
            while (quarters > 0) {
                [changeString appendString:@"QUARTER,"];
                changeNumber = [changeNumber decimalNumberBySubtracting:quarter];
                quarters--;
            }           
        }
            break;
            
        default:
            break;
    }
    
    // Check for Dimes
    NSComparisonResult dimeResult = [changeNumber compare:[NSNumber numberWithFloat:.10]];
    switch (dimeResult) {
        case NSOrderedSame:
        case NSOrderedDescending:
        {
            // divide by .10, and append that many dimes to the string
            NSDecimalNumber * dime = [NSDecimalNumber decimalNumberWithDecimal:[NSNumber numberWithFloat:.10].decimalValue];
            NSDecimalNumber * dimesCount = [changeNumber decimalNumberByDividingBy:dime withBehavior:handler];
            int dimes = dimesCount.intValue;
            while (dimes > 0) {
                [changeString appendString:@"DIME,"];
                changeNumber = [changeNumber decimalNumberBySubtracting:dime];
                dimes--;
            }            
        }
            break;
            
        default:
            break;
    }
    
    // Check for Nickels
    NSComparisonResult nickelResult = [changeNumber compare:[NSNumber numberWithFloat:.05]];
    switch (nickelResult) {
        case NSOrderedSame:
        case NSOrderedDescending:
        {
            // divide by .05, and append that many nickels to the string
            NSDecimalNumber * nickel = [NSDecimalNumber decimalNumberWithDecimal:[NSNumber numberWithFloat:.05].decimalValue];
            NSDecimalNumber * nickelsCount = [changeNumber decimalNumberByDividingBy:nickel withBehavior:handler];
            int nickels = nickelsCount.intValue;
            while (nickels > 0) {
                [changeString appendString:@"NICKEL,"];
                changeNumber = [changeNumber decimalNumberBySubtracting:nickel];
                nickels--;
            }

        }
            break;
            
        default:
            break;
    }

    
    // Check for Pennies
    NSComparisonResult pennyResult = [changeNumber compare:[NSNumber numberWithFloat:.01]];
    switch (pennyResult) {
        case NSOrderedSame:
        case NSOrderedDescending:
        {
            // divide by .01, and append that many pennies to the string
            NSDecimalNumber * penny = [NSDecimalNumber decimalNumberWithDecimal:[NSNumber numberWithFloat:.01].decimalValue];
            NSDecimalNumber * pennyCount = [changeNumber decimalNumberByDividingBy:penny withBehavior:handler];
            int pennies = pennyCount.intValue;
            while (pennies > 0) {
                [changeString appendString:@"PENNY,"];
                changeNumber = [changeNumber decimalNumberBySubtracting:penny];
                pennies--;
            }
        }
            break;
            
        default:
            break;
    }
    

    
    NSRange lastCommaCheck = NSMakeRange(changeString.length-1, 1);
    NSString * commaCheck = [changeString substringWithRange:lastCommaCheck];
    if ([commaCheck isEqualToString:@","]) {
        [changeString deleteCharactersInRange:lastCommaCheck];
    }
    return changeString;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Error checking for no value or empty strings in text field
    if (!textField.text || [textField.text isEqualToString:@""]) {
        // Show an alert view to alert the user
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"No Path" message:@"Pleaase enter a file path in the text field." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
        // dismiss the keyboard
        [textField resignFirstResponder];
        return YES;
    }
    
    // dismiss the keyboard
    [textField resignFirstResponder];
    
    // process the path to get the file
    [self processInputFileForPath:textField.text];
    
    return YES;
}

@end
