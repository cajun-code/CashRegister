//
//  ViewController.h
//  CashReegister
//
//  Created by Allan Davis on 8/22/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

/*
   We could (and should put most of these in the private interface but for simpliciy
   they will be put here.
 */

// model
@property (nonatomic) float purchasePrice;
@property (nonatomic) float paymentAmount;
@property (nonatomic, strong) NSMutableArray *changeArray;
@property (nonatomic, strong) NSMutableDictionary *currencyDictionary;

// ui
@property (nonatomic, weak) IBOutlet UITextField *purchasePriceTextField;
@property (nonatomic, weak) IBOutlet UITextField *paymentAmountTextField;
@property (nonatomic, weak) IBOutlet UIButton *calculateButton;
@property (nonatomic, weak) IBOutlet UILabel *resultLabel;

- (NSString *)validatePaymentAmount;
- (BOOL)updateButtonStatusForPurchasePrice:(float)price andPaymentAmount:(float)payment;
- (void)setupCurrencies;
- (NSString *)findLargestCurrencyForAmount:(float)amount;
- (IBAction)distributeChange:(id)sender;

@end
