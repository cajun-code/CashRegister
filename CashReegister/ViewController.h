//
//  ViewController.h
//  CashReegister
//
//  Created by Allan Davis on 8/22/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Currency.h"

@interface ViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtPrice;
@property (weak, nonatomic) IBOutlet UITextField *txtCash;
- (IBAction)btnChange:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrChange;
@property(strong,nonatomic)NSArray *arrCurrency;
@property(assign,nonatomic)int scrollHeight;

@end
