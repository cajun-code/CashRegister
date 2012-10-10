//
//  ViewController.h
//  CashReegister
//
//  Created by Allan Davis on 8/22/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtPurchasePrice;
@property (weak, nonatomic) IBOutlet UITextField *txtCashGiven;
@property (weak, nonatomic) IBOutlet UILabel *lblBalance;
@property (weak, nonatomic) IBOutlet UITextView *txtDenomination;

- (IBAction)runTransaction:(UIButton *)sender;
- (IBAction)didBeginEditing:(id)sender;

@end
