//
//  ViewController.h
//  CashReegister
//
//  Created by Allan Davis on 8/22/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong)NSString *inputFilePath;
@property (weak, nonatomic) IBOutlet UITextView *ReturnDenominantsOutput;

//Calculate the difference in the purchase price and chash price
- (void)CalculateChange:(NSString*)pInputFilePath;

//Calculates and returns the denominators of the amount passed to it as parameter
- (NSMutableDictionary *)CalculateDenominants:(NSInteger)pChangeAmount denominations:(NSArray *)pDenominations;
- (void)printOutput:(NSMutableArray *)pOutput;

@end
