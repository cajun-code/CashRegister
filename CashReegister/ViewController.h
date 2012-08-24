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

- (void)CalculateChange:(NSString*)pInputFilePath;

- (NSMutableDictionary *)CalculateDenominants:(NSInteger)pChangeAmount denominations:(NSArray *)pDenominations;
- (void)printOutput:(NSMutableArray *)pOutput;

@end
