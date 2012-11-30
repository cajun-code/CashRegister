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
    
    double cR=[self.cashRecived.text doubleValue];
    double pP=[self.productPrice.text doubleValue];
    
    NSMutableArray *output = [[NSMutableArray alloc] init];
    if (pP>0) {
        if (cR==pP) {
            [output addObject:@"ZERO"];
            
        }else if (cR<pP){
            
            [output addObject:@"ERROR"];
            
        }else{
            //converting difference by 100 to make it integer and to use modulus function on int
            int diff=(cR-pP)*100;
            
            //  NSLog(@" test : %d",diff);
            
            int PENNY,NICKEL,DIME,QUARTER,HALFDOLLAR,ONE,TWO,FIVE,TEN,TWENTY,FIFTY,ONEHUNDRED;
            
            ONEHUNDRED= diff/10000;
            if (ONEHUNDRED>0) {
                for (int i=0; i < ONEHUNDRED; i=i+1) {
                    [output addObject:@"ONEHUNDRED"];
                }
                
            }
            diff= diff % 10000;
            
            
            FIFTY=diff/5000;
            diff= diff % 5000;
            if (FIFTY>0) {
                for (int i=0; i < FIFTY; i=i+1) {
                    [output addObject:@"FIFTY"];
                }
            }
            
            
            TWENTY=diff/2000;
            diff= diff % 2000;
            if (TWENTY>0) {
                for (int i=0; i < TWENTY; i=i+1) {
                    [output addObject:@"TWENTY"];
                }
            }
            
            TEN=diff/1000;
            diff= diff % 1000;
            if (TEN>0) {
                for (int i=0; i < TEN; i=i+1) {
                    [output addObject:@"TEN"];
                }
            }
            
            FIVE=diff/500;
            diff= diff % 500;
            if (FIVE>0) {
                for (int i=0; i < FIVE; i=i+1) {
                    [output addObject:@"FIVE"];
                }
            }
            
            TWO=diff/200;
            diff= diff % 200;
            if (TWO>0) {
                for (int i=0; i < TWO; i=i+1) {
                    [output addObject:@"TWO"];
                }
            }
            
            ONE=diff/100;
            diff= diff % 100;
            if (ONE>0) {
                for (int i=0; i < ONE; i=i+1) {
                    [output addObject:@"ONE"];
                }
            }
            
            HALFDOLLAR=diff/50;
            diff= diff % 50;
            if (HALFDOLLAR>0) {
                for (int i=0; i < HALFDOLLAR; i=i+1) {
                    [output addObject:@"HALFDOLLAR"];
                }
            }
            
            QUARTER=diff/25;
            diff= diff % 25;
            if (QUARTER>0) {
                for (int i=0; i < QUARTER; i=i+1) {
                    [output addObject:@"QUARTER"];
                }
            }
            
            DIME=diff/10;
            diff= diff % 10;
            if (DIME>0) {
                for (int i=0; i < DIME; i=i+1) {
                    [output addObject:@"DIME"];
                }
            }
            
            NICKEL=diff/5;
            diff= diff % 5;
            if (NICKEL>0) {
                for (int i=0; i < NICKEL; i=i+1) {
                    [output addObject:@"NICKEL"];
                }
            }
            
            PENNY=diff;
            if (PENNY>0) {
                for (int i=0; i < PENNY; i=i+1) {
                    [output addObject:@"PENNY"];
                }
            }
            
        }

    }else{
        [output addObject:@"ERROR"];
    }
    
   [output sortUsingSelector:@selector(compare:)];


NSString * result = [output componentsJoinedByString:@","];
self.changeLabel.text=result;




}
@end
